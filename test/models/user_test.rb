# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  authority              :boolean
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  phone_no               :string
#  rating                 :float            default(0.0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    user = users(:one)
    assert user.valid?, user.errors.full_messages.inspect
  end
  test "uid cannot be more than length 9" do
    users.each do |user| 
      user.uid = user.uid + "1"
      assert_not user.valid?
    end
  end
  test "uid cannot be empty" do 
    users.each do |user|  
      user.uid = ''
      assert_not user.valid?
    end
  end
end
