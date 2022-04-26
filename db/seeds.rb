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
                        parking_type: rand(0..2),
                        usage_fee: rand(1..20),
                        discount: rand(1..25),
                        spaces: rand(5..1000),
                        user_id: owner.id }
    car_park = Ar::CarPark.new(car_park_params)
    CarPark::Creator.call(car_park)
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
