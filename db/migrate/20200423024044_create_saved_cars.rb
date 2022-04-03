class CreateSavedCars < ActiveRecord::Migration[6.0]
  def change
    create_table :saved_cars do |t|
      t.timestamps
    end
  end
end
