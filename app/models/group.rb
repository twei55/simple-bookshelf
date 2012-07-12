class Group < ActiveRecord::Base
	has_many :users
	has_one :admin

	has_many :entries
	has_many :books, :through => :entries

	validates_presence_of :name
end
