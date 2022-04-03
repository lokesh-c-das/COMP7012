class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.integer :year
      t.string :model
      t.string :make
      t.integer :price
      t.string :photo
      t.integer :mileage
      t.text :description
      t.integer :sold, default: 0
      t.integer :bought, default: 0
     

      t.timestamps
    end
  end
end
