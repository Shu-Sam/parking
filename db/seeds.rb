3.times do
  name = Faker::Internet.username
  email = Faker::Internet.email
  owner = User.create(name: name,
                      role: 'owner',
                      email: email,
                      password: 'qqq111')

  3.times do
    car_park_params = { title: Faker::Company.name,
                        address: Faker::Address.street_address,
                        parking_type: ["Ground parking", "Truck parking", "Underground guarded parking"].shuffle.first,
                        usage_fee: rand(1..20),
                        discount: rand(1..25),
                        spaces: rand(5..1000),
                        user_id: owner.id }
    CarParkServices::CarParkCreator.call(car_park_params)
  end
end

3.times do
  name = Faker::Internet.username
  email = Faker::Internet.email
  User.create(name: name,
              role: 'driver',
              email: email,
              password: 'qqq111')
end
