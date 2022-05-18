class AvailabilityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    bookings = Reservation.where(['car_park_id =?', record.car_park_id])
    date_ranges = bookings.map { |b| b.start_date..b.end_date }

    overlapping_ranges = date_ranges.select { |range| range.include? value }
    return unless overlapping_ranges.size >= record.car_park.spaces

    record.errors.add(attribute, 'error! - There are no parking spaces on this day')
  end
end
