class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car_park, class_name: 'Ar::CarPark'

  validates :start_date, :end_date, presence: true, availability: true
  validate :end_date_after_start_date
  validate :start_date_before_today
  validate :booking_period_30_days
  validate :end_day_after_unavailable_day

  scope :current_reservations, -> { where('end_date >= ?', Time.now) }
  scope :past_reservations, -> { where('end_date < ?', Time.now) }
  scope :owner_list, lambda { |user|
    select('users.email, car_park.user_id, reservations.car_park_id, reservations.start_date, reservations.end_date')
      .joins(:car_park, :user).where(car_park: { user_id: user.id }).includes([:user])
  }

  def self.available_range
    min_day..max_day
  end

  def self.min_day
    Date.today
  end

  def self.max_day
    min_day + 2.months
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, 'must be after the start date') if end_date < start_date
  end

  def start_date_before_today
    return if end_date.blank? || start_date.blank?

    errors.add(:start_date, ' must not be before today') if start_date < Date.today
  end

  def booking_period_30_days
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, 'is too far away. Booking period must be less than 30 days') if (end_date - start_date) >= 30
  end

  def end_day_after_unavailable_day
    return if end_date.blank? || start_date.blank?

    return unless car_park.unavailable_dates.find { |date| (start_date..end_date).include?(date) }

    errors.add(:base, 'The booking range must not include unavailable days.')
  end
end
