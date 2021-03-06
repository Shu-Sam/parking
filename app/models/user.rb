class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

  enum role: { driver: 0, owner: 1, admin: 2 }, _suffix: :role

  has_many :reservations
  has_many :comments
  has_many :car_parks, class_name: 'Ar::CarPark'
end
