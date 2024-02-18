class AddLabelsToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :labels, :json, default: []
    add_check_constraint :tasks, "JSON_TYPE(labels) = 'array'", name: 'task_labels_is_array'
  end
end
