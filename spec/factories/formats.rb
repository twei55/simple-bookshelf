# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
 	factory :dossier, :class => Format do
		name "Dossier"
	end

	factory :studie, :class => Format do
	  name "Studie"
	end

	factory :gesetz, :class => Format do
	  name "Gesetzentwurf"
	end

	factory :roman, :class => Format do
	  name "Roman"
	end

end
