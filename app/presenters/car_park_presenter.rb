class CarParkPresenter < ApplicationPresenter
  def title
    @model.title.capitalize
  end

  def fee_currency_byn
    @view.number_to_currency(usage_fee, unit: 'BYN', precision: 1, format: '%n %u')
  end
end
