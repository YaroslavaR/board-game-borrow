class ChangeDateFormatInRentals < ActiveRecord::Migration[5.0]
  def change
    change_column :rentals, :start_time,  :date
    change_column :rentals, :end_time,  :date
  end
end
