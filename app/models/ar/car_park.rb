module Ar
  class CarPark < ApplicationRecord
    belongs_to :user
    has_many :comments, as: :commentable
    has_many :reservations, dependent: :destroy
    has_many :users, through: :reservations
    has_rich_text :body

    enum parking_type: {
      'Ground parking': 0,
      'Truck parking': 1,
      'Underground guarded parking': 2
    }

    validates :title, uniqueness: true, length: { in: 2..20 }
    validates :spaces, numericality: { in: 2..10_000 }
    validates :discount, numericality: { in: 0..25 }
    validates :title, :address, :parking_type, :usage_fee, :discount, :spaces, presence: true

    def self.search(params)
      return all if params[:address_search].blank?

      where('title ILIKE :input_value OR address ILIKE :input_value', { input_value:
                                                                    "%#{sanitize_sql_like(params[:address_search])}%" })
    end

    def self.date_filter(params)
      start_filter_date = Date.civil(params[:start][:year].to_i, params[:start][:month].to_i,
                                     params[:start][:day].to_i)

      end_filter_date = Date.civil(params[:end][:year].to_i, params[:end][:month].to_i,
                                   params[:end][:day].to_i)

      all.select { |cp| (cp.unavailable_dates & (start_filter_date..end_filter_date).to_a).empty? }
    end

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
