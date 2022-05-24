class CarParkPresenter < ApplicationPresenter
  def title
    @model.title.capitalize
  end

  def type
    @model.parking_type.titleize
  end

  def fee_currency_byn
    @view.number_to_currency(usage_fee, unit: 'BYN', precision: 1, format: '%n %u')
  end

  def discount_percentage
    @view.number_to_percentage(discount, precision: 0)
  end

  def count_style(date)
    count = @model.count_available_spaces(date)
    case count
    when 0 then { color: 'bg-danger bg-opacity-50', count: 'unavailable' }
    when 1..20 then { color: 'bg-warning bg-opacity-25', count: "#{count} space".pluralize(count) }
    else { color: 'bg-success bg-opacity-25', count: '> 20 spaces' }
    end
  end
end
