Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  root 'car_parks#index'

  resources :car_parks, as: 'ar_car_park' do
   resources :comments, module: :car_parks
  end

  resources :car_parks, as: 'ar_car_parks', only: :index do
    resources :comments, module: :car_parks, only: :index
  end

  resources :comments do
    resources :comments, module: :comments
  end
end
