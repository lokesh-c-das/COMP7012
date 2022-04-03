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
class Conversation < ActiveRecord::Base
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

    has_many :messages, dependent: :destroy

    validates_uniqueness_of :sender_id, :scope => :recipient_id
    validates :sender_id, :recipient_id, presence: true
    validate :sender_recipient_cannot_be_same

    scope :between, -> (sender_id, recipient_id) do 
        where ("(conversations.sender_id = ? AND conversations.recipient_id = ?)
        OR (conversations.sender_id = ? AND conversations.recipient_id = ?)"), 
        sender_id, recipient_id, recipient_id, sender_id
    end

    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

    def sender_recipient_cannot_be_same
        if sender_id == recipient_id
            errors.add(:recipient_id, ": must not be same as sender_id")
        end
    end
end
