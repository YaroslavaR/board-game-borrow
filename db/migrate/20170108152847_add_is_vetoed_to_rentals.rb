class AddIsVetoedToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :is_vetoed, :integer
  end
end
