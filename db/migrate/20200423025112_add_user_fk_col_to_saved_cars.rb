class AddUserFkColToSavedCars < ActiveRecord::Migration[6.0]
  def change
    add_reference :saved_cars, :user, foreign_key: true
  end
end
