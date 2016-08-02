source 'https://rubygems.org'
ruby '2.2.5'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Need tzinfo-data for reasons mahtai doesn't understand
gem 'tzinfo-data'
gem 'social-share-button'

gem 'sendgrid'
# Use figaro to read environment variables from application.yml
gem 'figaro'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'addressable'
#jQuery gem for using datepicker
gem 'jquery-ui-rails'

# Use devise and omniauth for authentication
gem 'devise'
gem 'devise_invitable'
gem 'omniauth'
gem 'omniauth-google-oauth2'

#inline svg helper
gem 'inline_svg'

gem 'newrelic_rpm'

# Parse addresses
#https://github.com/daveworth/Indirizzo
gem 'Indirizzo'

gem 'pundit'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

gem 'faker', '~> 1.6', '>= 1.6.1'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.1'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'shoulda'
  gem 'launchy'
  gem 'valid_attribute'
  gem 'byebug'
  gem 'pry-rails'
  gem 'capybara'
  gem 'quiet_assets'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rake'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use dotenv for local configs
  gem 'dotenv-rails'

  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm'
end

group :production do
  #12 Factor for Heorku
  gem 'rails_12factor'
end
gem 'nokogiri', '>= 1.6.8'
