require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
  user_data = [
    { first_name: 'Barbara', last_name: 'Gordon', email: 'BarbaraGordon@gmail.com', password: 'password' },
    { first_name: 'Bruce', last_name: 'Wayne', email: 'BruceWayne@gmail.com', password: 'password' },
    { first_name: 'Steven', last_name: 'Rogers', email: 'StevenRogers@gmail.com', password: 'password' },
    { first_name: 'Billy', last_name: 'Batson', email: 'BillyBatson@gmail.com', password: 'password' },
    { first_name: 'Selina', last_name: 'Kyle', email: 'SelinaKyle@gmail.com', password: 'password'},
    { first_name: 'Victor', last_name:  'Von Doom', email: 'VictorVonDoom@gmail.com', password: 'password' },
    { first_name: 'Emma', last_name: 'Frost', email: 'EmmaFrost@gmail.com', password: 'password' },
    { first_name: 'Matthew', last_name: 'Murdock', email: 'MatthewMurdock@gmail.com', password: 'password' },
    { first_name: 'Jonathan', last_name: 'Osterman', email: 'JonathanOsterman@gmail.com', password: 'password' },
    { first_name: 'Walter', last_name: 'Kovacs', email: 'WalterKovacs@gmail.com', password: 'password' },
    { first_name: 'Tim', last_name: 'Drake', email: 'TimDrake@gmail.com', password: 'password' },
    { first_name: 'Barry', last_name: 'Allen', email: 'BarryAllen@gmail.com', password: 'password' },
    { first_name: 'Harvey', last_name: 'Dent', email: 'HarveyDent@gmail.com', password: 'password' },
    { first_name: 'Oswald', last_name: 'Cobblepot', email: 'OswaldCobblepot@gmail.com', password: 'password' },
    { first_name: 'Peter', last_name: 'Parker', email: 'PeterParker@gmail.com', password: 'password' },
    { first_name: 'Bruce', last_name: 'Banner', email: 'BruceBanner@gmail.com', password: 'password' },
    { first_name: 'Scott', last_name: 'Summers', email: 'ScottSummers@gmail.com', password: 'password' },
    { first_name: 'Natasha', last_name: 'Romanova', email: 'NataliaRomanova@gmail.com', password: 'password' },
    { first_name: 'Cain', last_name: 'Marko', email: 'CainMarko@gmail.com', password: 'password' },
    { first_name: 'Charles', last_name: 'Xavier', email: 'CharlesXavier@gmail.com', password: 'password' }
  ]

  users ||= user_data.map { |user| User.create(user.merge(phone: '5555555555')) }

  team_data = [
    { name: 'Team Awesome', image_url: '' },
    { name: 'Team FancyPants', image_url: '' },
    { name: 'Team The Best Team Ever', image_url: '' },
    { name: 'Team Not So Great', image_url: '' },
    { name: 'Team Meets Expectations', image_url: '' }
  ]

  teams ||= team_data.map { |team| Team.create(team) }


  # assign teams
  users[0..-4].each_slice(2).with_index do |slice, index|
    slice.each do |user|
      user.team = teams[index]
      user.save
    end
  end

  # create and assign units
  users.each do |user|
    user_building = UserBuilding.create(address: Faker::Address.street_address)
    unit = Unit.create(
      user_building: user_building,
      unit_number: 4,
      sqfootage: 900,
      number_bedrooms: 2,
      number_bathrooms: 1,
      number_rooms: 2,
      number_occupants: 1
    )
    user.unit = unit
    user.save
  end

  # create and assign bills
  users.each_with_index do |user, index|
    (1..5).map do
      Bill.create(
        bill_received: Faker::Time.between(DateTime.now - 1.year, DateTime.now),
        amount: rand(75..175),
        user: user,
        unit: user.unit
      )
    end
  end
end
end
