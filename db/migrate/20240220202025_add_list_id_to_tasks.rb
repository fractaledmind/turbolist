class AddListIdToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :list, null: false, foreign_key: true
  end
end
