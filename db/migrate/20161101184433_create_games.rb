class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :min_players
      t.integer :max_players
      t.integer :min_player_age
      t.integer :max_player_age
      t.integer :playing_time
      t.float :complexity
      t.string :location
      t.string :link

      t.timestamps
    end
  end
end
