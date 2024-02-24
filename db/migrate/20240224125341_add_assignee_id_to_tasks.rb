class AddAssigneeIdToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :assignee, null: false, foreign_key: true
  end
end
