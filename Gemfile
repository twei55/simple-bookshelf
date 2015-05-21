source 'https://rubygems.org'

gem 'acts_as_tree', '~> 0.1.1'
gem 'better_partials', '~> 1.0.1'
gem 'capistrano'
gem 'capistrano-rbenv'
gem 'devise'
gem 'mysql2', '~> 0.3.11'
gem 'newrelic_rpm'
gem 'paperclip', '~> 3.0'
gem 'rails', '~> 3.2.13'
gem 'simple_form'
gem 'therubyracer'
gem 'thin', '~> 1.3.1'
gem 'thinking-sphinx', '~> 2.0.14'
gem 'will_paginate', '~> 3.0'

group :assets do
	gem 'twitter-bootstrap-rails'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :development, :test do
	gem 'rspec-rails', '~> 2.8'
	gem 'factory_girl_rails', '~> 1.2'
	gem 'database_cleaner', '~> 0.7.2'
	gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
	gem 'launchy'
	gem 'differ'
end

group :production do
	gem 'passenger'
end
