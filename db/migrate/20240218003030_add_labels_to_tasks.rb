class AddLabelsToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :labels, :json
  end
end
