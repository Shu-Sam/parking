class CarParkPresenter < ApplicationPresenter
  def title
    @model.title.capitalize
  end

  def fee_currency_byn
    @view.number_to_currency(usage_fee, unit: 'BYN', precision: 1, format: '%n %u')
  end

  def discount_percentage
    @view.number_to_percentage(discount, precision: 0)
  end
end
