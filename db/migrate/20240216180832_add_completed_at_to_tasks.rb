class AddCompletedAtToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :completed_at, :datetime
  end
end
