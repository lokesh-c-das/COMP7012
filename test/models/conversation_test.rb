# == Schema Information
#
# Table name: conversations
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => users.id) ON DELETE => cascade
#  fk_rails_...  (sender_id => users.id) ON DELETE => cascade
#

class ConversationTest < ActiveSupport::TestCase
    test "sender and recipient cannot be same" do
        conversations.each do |c|
            c.sender_id = c.recipient_id
            assert_not c.valid?
        end
    end
    test "sender_id cannot be empty" do
        conversations.each do |c|
            sender_id = c.sender_id
            c.sender_id = ""
            assert_not c.valid?
            
            c.sender_id = sender_id
            c.sender_id = nil
            assert_not c.valid?
        end
    end
end