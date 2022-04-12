class CarPark < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: true
  validates :title, :address, :parking_type, :usage_fee, :discount, :spaces, presence: true
end
