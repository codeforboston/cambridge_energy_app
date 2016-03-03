FactoryGirl.define do
  factory :user do
    first_name 'MyString'
    last_name 'MyString'
    street_address 'MyString'
    phone 1
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
  end

  factory :bill do
    bill_received '2015-12-13'
    amount 19.99
    user
  end
end
