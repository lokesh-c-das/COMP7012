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
class Rating < ApplicationRecord
    belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
end
