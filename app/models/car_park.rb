class CarPark < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  validates :title, uniqueness: true
  validates :title, :address, :parking_type, :usage_fee, :discount, presence: true
end
