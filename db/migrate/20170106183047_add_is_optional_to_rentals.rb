class AddIsOptionalToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :is_optional, :integer, default: 0
  end
end
