Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  root 'car_parks#index'
  resources :car_parks
end
