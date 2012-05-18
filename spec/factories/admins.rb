# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
  	sequence(:email) {|n| "admin#{n}@domain.com" }
  	password "test1234"
  	password_confirmation "test1234"
  end
end
