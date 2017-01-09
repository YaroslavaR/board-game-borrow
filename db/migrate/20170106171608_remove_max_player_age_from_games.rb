class RemoveMaxPlayerAgeFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :max_player_age, :integer
  end
end
