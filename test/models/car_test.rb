# == Schema Information
#
# Table name: cars
#
#  id          :bigint           not null, primary key
#  bought      :integer          default(0)
#  description :text
#  make        :string
#  mileage     :integer
#  model       :string
#  photo       :string
#  price       :integer
#  sold        :integer          default(0)
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_cars_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "year has to be between current year and 1900" do
    cars.each do |car|
      year = car.year
      car.year = Date.today.year + 2
      assert_not car.valid?
      
      car.year = year
      car.year = car.year - 1900
      if car.year < 0 
        assert_not car.valid?
      end
    end
  end
  test "year cannot be negative" do
    cars.each do |car|
      car.year = car.year * (-1)
      assert_not car.valid?
    end
  end
  test "price cannot be negative" do
    cars.each do |car|
      car.price = car.price * (-1)
      assert_not car.valid?
    end
  end
  test "year cannot be empty" do
    cars.each do |car|
      year = car.year
      car.year = ""
      assert_not car.valid?
      
      car.year = year
      car.year = nil
      assert_not car.valid?
    end
  end
  test "model cannot be empty" do
    cars.each do |car|
      model = car.model
      car.model = ""
      assert_not car.valid?
      
      car.model = model
      car.model = nil
      assert_not car.valid?
    end
  end
  test "make cannot be empty" do
    cars.each do |car|
      make = car.make
      car.make = ""
      assert_not car.valid?
      
      car.make = make
      car.make = nil
      assert_not car.valid?
    end
  end
  test "price cannot be empty" do
    cars.each do |car|
      price = car.price
      car.price = ""
        assert_not car.valid?
      car.price = price
      car.price = nil
        assert_not car.valid?
    end
  end
end
