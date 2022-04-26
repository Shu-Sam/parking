module Ar
  class CarPark < ApplicationRecord
    belongs_to :user
    has_many :comments, as: :commentable
    has_rich_text :body

    enum parking_type: {
      Ground_parking: 0,
      Truck_parking: 1,
      Underground_guarded_parking: 2
    }

    validates :title, uniqueness: true, length: { in: 2..20 }
    validates :spaces, numericality: { in: 2..10_000 }
    validates :discount, numericality: { in: 0..25 }
    validates :title, :address, :parking_type, :usage_fee, :discount, :spaces, presence: true
  end
end
