source "http://rubygems.org"
source "http://gems.github.com"

gem "acts_as_tree", "~> 0.1.1"
gem "better_partials", "~> 1.0.1"
gem "capistrano"
gem "devise"
gem "mysql2", "~> 0.3"
gem "paperclip", "~> 3.0"
gem "rails", "3.2.2"
gem 'rvm-capistrano'
gem "simple_form"

gem "thin", "~> 1.3.1"
gem "thinking-sphinx", "2.0.10"
gem "will_paginate", "~> 3.0"

group :assets do
	gem "twitter-bootstrap-rails"
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem "webrat"
# end

group :development, :test do
	# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
	gem "ruby-debug19", :require => "ruby-debug"

	gem "rspec-rails", "~> 2.8"
	gem "factory_girl_rails", "~> 1.2"
	gem "database_cleaner", "~> 0.7.2"
	gem "capybara", :git => "git://github.com/jnicklas/capybara.git"
	gem "launchy"
	gem "differ"
end