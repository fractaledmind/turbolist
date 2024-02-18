class Task < ApplicationRecord
  include ArrayColumns

  has_rich_text :description

  attribute :labels, type: Array, default: []
  array_columns :labels

  validates :title, presence: true

  def completed? = completed_at.present?

  def completed=(_value)
    if completed_at.present?
      self.completed_at = nil
    else
      self.completed_at = Time.current
    end
  end
end
