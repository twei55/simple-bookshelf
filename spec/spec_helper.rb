# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

require 'thinking_sphinx/test'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Database Cleaner settings
  # https://github.com/bmabey/database_cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:all) do
    DatabaseCleaner.start

    ThinkingSphinx::Test.start
    create_dummy_data
    ThinkingSphinx::Test.index
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end

  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end

def create_dummy_data

  # Create some authors
  gibson = FactoryGirl.create(:gibson)
  timm = FactoryGirl.create(:timm)
  rowohlt = FactoryGirl.create(:rowohlt)
  haruki = FactoryGirl.create(:haruki)
  meier = FactoryGirl.create(:meier)
  
  # Create some formats
  dossier = FactoryGirl.create(:dossier)
  studie = FactoryGirl.create(:studie)
  gesetz = FactoryGirl.create(:gesetz)
  roman = FactoryGirl.create(:roman)

  # Create some tags
  tag1 = FactoryGirl.create(:tag1)
  tag3 = FactoryGirl.create(:tag3)
  tag4 = FactoryGirl.create(:tag4)
  tag5 = FactoryGirl.create(:tag5)
  tag6 = FactoryGirl.create(:tag6)
  tag7 = FactoryGirl.create(:tag7)
  tag8 = FactoryGirl.create(:tag8)
  
  tag2 = FactoryGirl.create(:tag2, :children => [tag6, tag7, tag8])

  # Create some books
  FactoryGirl.create(:book0, :authors => [gibson], :formats => [roman], :nested_tags => [tag1])
  FactoryGirl.create(:book1, :authors => [gibson], :formats => [roman], :nested_tags => [tag1, tag2])
  FactoryGirl.create(:book2, :authors => [timm], :formats => [studie], :nested_tags => [tag2])
  FactoryGirl.create(:book3, :authors => [timm], :formats => [studie], :nested_tags => [tag3])
  FactoryGirl.create(:book4, :authors => [rowohlt], :formats => [dossier], :nested_tags => [tag4])
  FactoryGirl.create(:book5, :authors => [haruki], :formats => [dossier], :nested_tags => [tag1, tag5])
  FactoryGirl.create(:book6, :authors => [haruki], :formats => [gesetz], :nested_tags => [tag5])
  FactoryGirl.create(:book7, :authors => [haruki], :formats => [gesetz], :nested_tags => [tag3])
  FactoryGirl.create(:book8, :authors => [meier], :formats => [roman], :nested_tags => [tag3])
  FactoryGirl.create(:book9, :authors => [meier], :formats => [roman], :nested_tags => [tag3])

end
