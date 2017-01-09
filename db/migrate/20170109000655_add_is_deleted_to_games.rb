class AddIsDeletedToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :is_deleted, :integer
  end
end
