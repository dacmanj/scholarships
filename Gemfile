source 'https://rubygems.org'
ruby '2.3.1'
gem 'rails', '3.2.22.2'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 3.0.3.0'
  gem 'i18n-js'
  gem 'jquery-validation-rails'
end

gem 'paperclip', git: 'https://github.com/thoughtbot/paperclip',
                 ref: '523bd46c768226893f23889079a7aa9c73b57d68'
gem 'aws-sdk'
gem 'descriptive-statistics'
gem 'test-unit'

gem 'tinymce-rails'
gem 'jquery-rails'
gem 'annotate'
gem 'cancan'
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'figaro'
gem 'rolify'
gem 'simple_form'
gem 'pg'

gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'

group :development do
  gem 'better_errors'
  gem 'faker', '~> 1.2.0'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :production do
  gem 'thin'
end
group :test do
  gem 'sqlite3'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
end
