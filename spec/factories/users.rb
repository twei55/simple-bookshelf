# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email) {|n| "user#{n}@domain.com" }
  	password "test1234"
  	password_confirmation "test1234"
    confirmed_at Time.now
  end

  factory :admin, :class => User do
		sequence(:email) {|n| "admin#{n}@domain.com" }
  	password "test1234"
  	password_confirmation "test1234"
    confirmed_at Time.now
  	admin true
  end
end
