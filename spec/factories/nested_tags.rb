# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

	factory :tag1, :class => NestedTag do
	  name "Alleinerziehende"
	  parent_id 0
	end

	factory :tag2, :class => NestedTag do
	  name "Bildung"
	  parent_id 0
	end

	factory :tag3, :class => NestedTag do
	  name "Unterhaltsrecht"
	  parent_id 0
	end

	factory :tag4, :class => NestedTag do
	  name "Erziehung"
	  parent_id 0
	end

	factory :tag5, :class => NestedTag do
	  name "Science"
	  parent_id 0
	end

	factory :tag6, :class => NestedTag do
		name "Abbildung"
	end

	factory :tag7, :class => NestedTag do
		name "Ausbildung"
	end

	factory :tag8, :class => NestedTag do
		name "Vorbildung"
	end

end