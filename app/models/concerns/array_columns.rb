module ArrayColumns
  extend ActiveSupport::Concern

  class_methods do
    def array_columns_sanitize_list(values = [])
      return [] if values.nil?
      values.select(&:present?).map(&:to_s).uniq.sort
    end

    def array_columns(*column_names)
      @array_columns ||= {}

      array_columns_sanitize_list(column_names).each do |column_name|
        @array_columns[column_name] ||= false
      end

      @array_columns.each do |column_name, initialized|
        next if initialized

        column_name = column_name.to_s
        method_name = column_name.downcase

        # JSON_EACH("{table}"."{column}")
        json_each = Arel::Nodes::NamedFunction.new("JSON_EACH", [ arel_table[column_name] ])

        # SELECT DISTINCT value FROM "{table}", JSON_EACH("{table}"."{column}")
        define_singleton_method :"unique_#{method_name}" do |conditions = "true"|
          select("value")
            .from([ arel_table, json_each ])
            .distinct
            .pluck("value")
            .sort
        end

        # SELECT value, COUNT(*) AS count FROM "{table}", JSON_EACH("{table}"."{column}") GROUP BY value ORDER BY value
        define_singleton_method :"#{method_name}_cloud" do |conditions = "true"|
          select("value")
            .from([ arel_table, json_each ])
            .group("value")
            .order("value")
            .pluck(Arel.sql("value, COUNT(*) AS count"))
            .to_h
        end

        # SELECT "{table}".* FROM "{table}" WHERE "{table}"."{column}" IS NOT NULL AND "{table}"."{column}" != '[]'
        scope :"with_#{method_name}", -> {
          where.not(arel_table[column_name].eq(nil))
            .where.not(arel_table[column_name].eq([]))
        }

        # SELECT "{table}".* FROM "{table}" WHERE ("{table}"."{column}" IS NULL OR "{table}"."{column}" = '[]')
        scope :"without_#{method_name}", -> {
          where(arel_table[column_name].eq(nil))
            .or(where(arel_table[column_name].eq([])))
        }

        # SELECT "{table}".* FROM "{table}" WHERE EXISTS (SELECT 1 FROM JSON_EACH("{table}"."{column}") WHERE value IN ({values}) LIMIT 1)
        scope :"with_any_#{method_name}", ->(*items) {
          values = array_columns_sanitize_list(items)
          overlap = Arel::SelectManager.new(json_each)
            .project(1)
            .where(Arel.sql("value").in(values))
            .take(1)
            .exists

          where overlap
        }

        # SELECT "{table}".* FROM "{table}" WHERE (SELECT COUNT(*) FROM JSON_EACH("{table}"."{column}") WHERE value IN ({values})) = {values.size};
        scope :"with_all_#{method_name}", ->(*items) {
          values = array_columns_sanitize_list(items)
          count = Arel::SelectManager.new(json_each)
            .project(Arel.sql("value").count(distinct = true))
            .where(Arel.sql("value").in(values))
          contains = Arel::Nodes::Equality.new(count, values.size)

          where contains
        }

        # SELECT "{table}".* FROM "{table}" WHERE NOT EXISTS (SELECT 1 FROM JSON_EACH("{table}"."{column}") WHERE value IN ({values}) LIMIT 1)
        scope :"without_any_#{method_name}", ->(*items) {
          values = array_columns_sanitize_list(items)
          overlap = Arel::SelectManager.new(json_each)
            .project(1)
            .where(Arel.sql("value").in(values))
            .take(1)
            .exists
          where.not overlap
        }

        # SELECT "{table}".* FROM "{table}" WHERE (SELECT COUNT(*) FROM JSON_EACH("{table}"."{column}") WHERE value IN ({values})) != {values.size};
        scope :"without_all_#{method_name}", ->(*items) {
          values = array_columns_sanitize_list(items)
          count = Arel::SelectManager.new(json_each)
            .project(Arel.sql("value").count(distinct = true))
            .where(Arel.sql("value").in(values))
          contains = Arel::Nodes::Equality.new(count, values.size)
          where.not contains
        }

        before_validation -> { self[column_name] = self.class.array_columns_sanitize_list(self[column_name]) }

        define_method :"has_any_#{method_name}?" do |*values|
          values = self.class.array_columns_sanitize_list(values)
          existing = self.class.array_columns_sanitize_list(self[column_name])
          (values & existing).present?
        end

        define_method :"has_all_#{method_name}?" do |*values|
          values = self.class.array_columns_sanitize_list(values)
          existing = self.class.array_columns_sanitize_list(self[column_name])
          (values & existing).size == values.size
        end

        alias_method :"has_#{method_name.singularize}?", :"has_all_#{method_name}?"

        @array_columns[column_name] = true
      end
    end
  end
end
