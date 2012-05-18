# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do 

  factory :author do
    first_name "Vorname"
    last_name "Nachname"

    factory :rowohlt do
      first_name "Harry"
      last_name "Rowohlt"
    end

    factory :timm do
      first_name "Uwe"
      last_name "Timm"
    end

    factory :haruki do
      first_name "Haruki"
      last_name "Murakami"
    end

    factory :gibson do
      first_name "William"
      last_name "Gibson"
    end

    factory :meier do
      first_name "Clemens"
      last_name "Meier"
    end

  end

end