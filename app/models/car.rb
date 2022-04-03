# == Schema Information
#
# Table name: cars
#
#  id          :bigint           not null, primary key
#  bought      :integer          default(0)
#  description :text
#  make        :string
#  mileage     :integer
#  model       :string
#  photo       :string
#  price       :integer
#  sold        :integer          default(0)
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_cars_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Car < ApplicationRecord
    has_one_attached :image
    has_many :saved_cars, dependent: :destroy
    belongs_to :user

    after_commit :add_default_car_image, on: [:create, :update]

    validates :make, presence: true
    validates :year, presence: true
    validates :model, presence: true
    validates :mileage, presence: true
    validates :price, presence: true
    validate :year_must_be_valid
    validate :price_mileage_cannot_be_negative

    def year_must_be_valid
        if !year.nil? and (year > Date.today.year or year < 1900)
            errors.add(:year, ": must be between 1900 and current year")
        end
    end

    def price_mileage_cannot_be_negative
        if !price.nil? and price < 0
            errors.add(:price, ": can't be negative")
        end
        if !mileage.nil? and mileage < 0 
            errors.add(:mileage, ": can't be negative")
        end
    end

    private def add_default_car_image
        unless image.attached?
            self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "cars", "default-car.jpg")), filename: 'default-car.jpg' , content_type: "image/jpg")
        end
    end
end
