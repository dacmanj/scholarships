source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '3.2.16'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 3.0.3.0'
  gem 'i18n-js'
end

gem 'paperclip'
gem 'aws-sdk'

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
group :development do
  gem 'pg'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :production do
  gem 'pg'
  gem 'thin'
end
group :test do
  gem 'sqlite3'
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
end
