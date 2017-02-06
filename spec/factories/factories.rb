FactoryGirl.define do
  factory :user do
    first_name 'Bob'
    last_name 'Everyman'
    phone '1234567890'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    unit
    team
    tipnum 1

    factory :user_with_bills do
      transient do
        bills_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:bill, evaluator.bills_count, user: user)
      end
    end
  end

  factory :bill do
    bill_received '2015-12-13'
    amount { rand(1..99.1).round(2) }
    usage { rand(200..500).round(0) }
    user
  end

  factory :team do
    name 'Team AwesomeSauce'

    factory :team_with_members do
      transient do
        users_count 3
      end

      after(:create) do |team, evaluator|
        create_list(:user_with_bills, evaluator.users_count, team: team)
      end
    end
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

  factory :user_tip do
    factory :user_tip_with_likes do
      result "Liked"
    end
    factory :user_tip_with_dislikes do
      result "Disliked"
    end
  end

  factory :tip do
    sequence(:text) { |n| "Do stuff #{n}" }
    factory :tip_with_likes do
      transient do
        user_tips_count 1 
      end
      after(:create) do |tip, evaluator|
        create_list(:user_tip_with_likes, evaluator.user_tips_count, tip: tip)
      end
    end
    factory :tip_with_dislikes do
      transient do
        user_tips_count 1 
      end
      after(:create) do |tip, evaluator|
        create_list(:user_tip_with_dislikes, evaluator.user_tips_count, tip: tip)
      end
    end
  end

end
