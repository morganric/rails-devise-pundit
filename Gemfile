source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '4.1.1'
gem 'sqlite3', group: :development
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'devise'
gem 'pundit'
gem 'simple_form'
gem 'thin'
gem "therubyracer"
gem "less-rails"
gem 'less-rails-bootstrap'
gem "twitter-bootstrap-rails"
# twitter bootstrap css & javascript toolkit
# gem 'twitter-bootswatch-rails', '~> 3.1.1'
# # twitter bootstrap helpers gem, e.g., alerts etc...
# gem 'twitter-bootswatch-rails-helpers'

gem 'twitter-bootswatch-rails'
gem 'twitter-bootswatch-rails-helpers'
gem 'carrierwave'
gem 'cloudinary'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '>= 3.0.0.beta2'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
