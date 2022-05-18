Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  root 'car_parks#index'

  resources :car_parks, as: 'ar_car_park' do
   resources :comments, module: :car_parks
   resources :reservations, only: [:new, :create, :edit, :update] do
     collection do
       get 'owner_index'
     end
   end
  end

  resources :reservations, only: [:index, :destroy]

  resources :car_parks, as: 'ar_car_parks', only: :index do
    resources :comments, module: :car_parks, only: :index
  end

  resources :comments do
    resources :comments, module: :comments
  end

end
