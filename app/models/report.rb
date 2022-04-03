# == Schema Information
#
# Table name: reports
#
#  id         :bigint           not null, primary key
#  body       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string
#
class Report < ApplicationRecord
    belongs_to :user, :foreign_key => :user_id, class_name: 'User'

    validates :body, :user_id, presence: true

    def message_time
        created_at.strftime("%m/%d/%y at %I:%M %p")
    end
end
