# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
class ConversationTest < ActiveSupport::TestCase
    test "message body cannot be empty" do
        messages.each do |message|
            body = message.body
            message.body = ""
            assert_not message.valid?

            message.body = body
            message.body = nil
            assert_not message.valid?
        end
    end
    test "message's user_id cannot be empty" do
        messages.each do |message|
            user = message.user_id
            message.user_id = ""
            assert_not message.valid?

            message.user_id = user
            message.user_id = nil
            assert_not message.valid?
        end
    end
    test "message's conversation_id cannot be empty" do
        messages.each do |message|
            conversation = message.conversation_id
            message.conversation_id = ""
            assert_not message.valid?

            message.conversation_id = conversation
            message.conversation_id = nil
            assert_not message.valid?
        end
    end
end



