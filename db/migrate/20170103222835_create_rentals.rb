class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
