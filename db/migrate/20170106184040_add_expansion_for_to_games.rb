class AddExpansionForToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :expansion_for, :integer
  end
end
