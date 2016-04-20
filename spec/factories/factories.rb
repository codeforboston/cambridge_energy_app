FactoryGirl.define do
  factory :user do
    first_name 'Bob'
    last_name 'Everyman'
    street_address '123 Main St.'
    phone '1234567890'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    unit
  end

  factory :bill do
    bill_received '2015-12-13'
    amount 19.99
    user
  end

  factory :team do
    name "Team AwesomeSauce"
  end

  factory :unit do
    number_occupants 1
  end
end
