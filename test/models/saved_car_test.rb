# == Schema Information
#
# Table name: saved_cars
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_saved_cars_on_car_id   (car_id)
#  index_saved_cars_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_id => cars.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class SavedCarTest < ActiveSupport::TestCase
  test "saved car fixtures are valid" do
    saved_cars.each do |sc|
      assert sc.valid?
    end
  end
end
