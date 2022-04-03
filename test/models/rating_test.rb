# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  buyer_id   :integer
#  seller_id  :integer
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => users.id) ON DELETE => cascade
#  fk_rails_...  (seller_id => users.id) ON DELETE => cascade
#
require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
