class AddAvatarToLists < ActiveRecord::Migration[7.2]
  def change
    add_column :lists, :avatar, :string
  end
end
