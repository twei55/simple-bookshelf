# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :book0, :class => Book do
	  title "Neuromancer"
	  year "2001"
	  publisher "Suhrkamp"
	  publisher_is_author false
	end

	factory :book1, :class => Book do
	  title "Mona Lisa Overdrive"
	  year "2001"
	  publisher "Suhrkamp"
	end

	factory :book2, :class => Book do
	  title "Die Erfindung der Currywurst"
	  year "2001"
	  publisher "Suhrkamp"
	end

	factory :book3, :class => Book do
	  title "Am Beispiel meines Bruders"
	  year "2001"
	  publisher "Suhrkamp"
	end

	factory :book4, :class => Book do
	  title "Ich, Kater Robinson."
	  year "2001"
	  publisher "Suhrkamp"
	end

	factory :book5, :class => Book do
	  title "Mister Aufziehvogel"
	  year "2001"
	  publisher "dtv"
	end

	factory :book6, :class => Book do
	  title "William Gibson"
	  year "2001"
	  publisher "dtv"
	end

	factory :book7, :class => Book do
	  title "Die Erfindung der Bratwurst"
	  year "2005"
	  publisher "rowohlt"
	end

	factory :book8, :class => Book do
	  title "Der Schlüssel zum Erfolg"
	  year "2008"
	  publisher "rororo"
	end

	factory :book9, :class => Book do
	  title "Der Schlüssel zum Scheitern"
	  year "2003"
	  publisher "rororo"
	end

end