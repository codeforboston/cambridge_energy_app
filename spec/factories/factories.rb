FactoryGirl.define do
  factory :user do
    first_name 'Bob'
    last_name 'Everyman'
    street_address '123 Main St.'
    phone '1234567890'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    unit
    team
  end

  factory :bill do
    bill_received '2015-12-13'
    amount 19.99
    user
  end

  factory :team do
    name 'Team AwesomeSauce'
  end

  factory :unit do
    number_occupants 1
    unit_number 123
    sqfootage 700
    number_bedrooms 2
    number_bathrooms 1
    number_rooms 2
    user_building
  end

  factory :user_building do
    address '123 Main St, Cambridge, MA 02138'
    lat 42.3736
    lon(-71.1097)
  end
end
