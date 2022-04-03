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
class Message < ActiveRecord::Base
    belongs_to :conversation, :foreign_key => :conversation_id, class_name: 'Conversation'
    belongs_to :user, :foreign_key => :user_id, class_name: 'User'

    validates :body, :conversation_id, :user_id, presence: true

    def message_time
        created_at.strftime("%m/%d/%y at %I:%M %p")
    end
end
