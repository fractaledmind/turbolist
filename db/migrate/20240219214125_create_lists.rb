class CreateLists < ActiveRecord::Migration[7.2]
  def change
    create_table :lists do |t|
      t.string :title

      t.timestamps
    end
  end
end
