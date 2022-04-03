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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :cars, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :saved_cars, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # For default user icon
  after_commit :add_default_photo, on: [:create, :update]
  private def add_default_photo
    unless photo.attached?
      self.photo.attach(io: File.open(Rails.root.join("app", "assets", "images", "user.png")), filename: 'user.png' , content_type: "image/jpg")
    end
  end

  validate :uid_must_begin_with_U_and_length_should_be_nine
  validate :email_must_be_of_uofm
  validates :uid, presence: true
  validates_uniqueness_of :uid, :allow_blank => true, :allow_nil => true

  def uid_must_begin_with_U_and_length_should_be_nine
    if !uid.empty?
      if !uid.start_with?("U") || uid.length>9
        errors.add(:uid, " is not valid")      
      end
    end
  end

  def email_must_be_of_uofm
    if !email.empty? && !email.end_with?("memphis.edu")
      errors.add(:email, " is not of UofM")
    end
  end
end
