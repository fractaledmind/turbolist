class AddAssigneeIdToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :assignee, null: true, foreign_key: { to_table: :users }
  end
end
