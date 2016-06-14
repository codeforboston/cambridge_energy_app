require 'faker'

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

tip_data = [
  { text: 'Learn how to estimate what it costs to operate your appliances and how much energy they consume.'},
  { text: 'Replacing your conventional power strips with advanced power strips can help reduce the electricity wasted when electronics are idle, without your having to change the way you normally use your devices.'},
  { text: 'Close your exterior doors and windows tightly when the AC is on. Save even more by turning off kitchen and bath exhaust fans.'},
  { text: 'Open interior doors so that cooled air flows freely throughout your home.'},
  { text: 'Decorate for a cooler home by hanging light-colored curtains that allow light to enter a room while blocking some of the sun’s rays, and light-colored paint to reflect heat.'},
  { text: 'Install more ceiling fans. Because the breeze of a fan can make you feel three to four degrees cooler, you can raise that thermostat and still stay comfortable'},
  { text: 'Install a programmable thermostat to adjust your temperature during the day.'},
  { text: 'Raise the temperature on your thermostat by a few degrees to save on your cooling costs.'},
  { text: 'Insulate your walls with injected foam insulation to help you save energy by keeping hot outside air from seeping through porous block walls – check with your local building supply company for details.'},
  { text: 'Replace standard bulbs with LEDs. They are much more energy-efficient than regular bulbs.'},
  { text: 'Use motion-detector lights for all your outdoor lighting – they’re convenient and efficient.'},
  { text: 'Select light-colored or opaque lamp shades. Place lamps in corners so they reflect light from two walls.'},
  { text: 'Replace your five most-used light fixtures and/or bulbs with ENERGY STAR® products. If every American did so, we would save about $8 billion per year in energy costs.'},
  { text: 'Pull the plug on that second fridge located in the hot garage or utility room. '},
  { text: 'Repair refrigerator door seals if you feel cold air around the closed door or if moisture is collecting.'},
  { text: 'Keep your freezer full – it uses less energy than an empty one. For maximum savings, consider filling your freezer with gallon containers of water.'},
  { text: "Wash and dry several loads at once, so that your dryer isn't completely cooled down when it heats up for the next load."},
  { text: 'Hang dress clothing to air dry on portable laundry racks; they will also look better.'},
  { text: 'Clean the dryer lint filter before every load to keep your dryer running efficiently.'},
  { text: 'Eliminate "hot spots" in your home by using High-performance windows, solar window screens and qualified window films.'},
  { text: 'Consider high-performance windows before you replace your AC system. They’re so efficient that they may help reduce the size and cost needed for a AC system.'},
  { text: 'Avoid energy vampires. Even when they’re turned off, home electronics in “standby” mode use energy to power features like clock displays.'},
  { text: 'Unplug battery chargers when the batteries are fully charged or the chargers are not in use. Many chargers draw power continuously, even when the device is not plugged into the charger.'},
  { text: 'Plug electronics into a power strip, then turn the strip off when not in use to save in energy costs.'},
  { text: 'Grill out more often during the summer. Using the oven in the heat of summer forces your AC to work harder, which raises your energy bill.'}]

tips ||= tip_data.map { |tip| Tip.create(tip) }

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
