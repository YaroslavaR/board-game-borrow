class AddRatingToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :rating, :float
  end
end
