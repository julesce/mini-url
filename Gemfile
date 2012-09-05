source 'https://rubygems.org'

gem 'rails', '3.2.8'

group :development, :test do
  gem 'rspec-rails', '~> 2.11.0'
  gem 'shoulda-matchers', '~> 1.2.0'
  gem 'factory_girl_rails', '~> 4.0.0'
  gem 'quiet_assets', '~> 1.0.0'
  gem 'sqlite3', '~> 1.3.6'
end

group :test do
  gem 'capybara', '~> 1.1.2'
end

group :production do
  gem 'pg'
  gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  # Twitter Bootstrap framework converted to Sass (2.0.4 seems to have some styling issues)
  gem "bootstrap-sass", "2.0.3.1"
end

gem 'jquery-rails', '~> 2.0.2'
gem 'newrelic_rpm'

# Make our searching lives a bit happier
gem 'squeel', '~> 1.0.10'