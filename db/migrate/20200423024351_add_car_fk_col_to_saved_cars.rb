class AddCarFkColToSavedCars < ActiveRecord::Migration[6.0]
  def change
    add_reference :saved_cars, :car, foreign_key: true
  end
end
