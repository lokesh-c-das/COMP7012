# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  conversation   :integer
#  identifier     :integer
#  notice_type    :integer
#  read           :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  notified_by_id :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_notifications_on_notified_by_id  (notified_by_id)
#  index_notifications_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (notified_by_id => users.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user
  #belongs_to :notified_by, class_name: "User"

  validates :user_id, :notified_by_id, :conversation, 
  :identifier, :notice_type, presence: true
end
