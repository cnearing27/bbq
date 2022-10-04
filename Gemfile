source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "carrierwave"
gem "devise"
gem "devise-i18n"
gem "dotenv-rails"
gem "font-awesome-rails"
gem "importmap-rails"
gem "jbuilder"
gem "jquery-rails"
gem "mailjet"
gem "omniauth"
gem "omniauth-github", github: "omniauth/omniauth-github", branch: "master"
gem "omniauth-rails_csrf_protection"
gem "pundit"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.1"
gem "rails-i18n"
gem "resque", "~>2.4"
gem "rmagick"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "twitter-bootstrap-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "capistrano", "3.17.1"
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rbenv"
  gem "capistrano-resque", require: false
  gem "capistrano-bundler"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg"
end
