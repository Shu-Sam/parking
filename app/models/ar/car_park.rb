module Ar
  class CarPark < ApplicationRecord
    belongs_to :user
    has_many :comments, as: :commentable
    has_many :reservations
    has_many :users, through: :reservations
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

    def unavailable_dates
      reservations.available_range.select do |day|
        count_unavailable_spaces(day) >= spaces
      end
    end

    def count_available_spaces(day)
      spaces - count_unavailable_spaces(day)
    end

    private

    def count_unavailable_spaces(day)
      overlapping_ranges(booked_ranges, day).size
    end

    def overlapping_ranges(ranges, day)
      ranges.select { |r| r.include?(day) }
    end

    def booked_ranges
      reservations.pluck(:start_date, :end_date).map { |date| date[0]..date[1] }
    end
  end
end
