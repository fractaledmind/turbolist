class AddDueOnToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :due_on, :date
  end
end
