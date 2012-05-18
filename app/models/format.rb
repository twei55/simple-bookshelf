class Format < ActiveRecord::Base

	################################
  ### ActiveRecord Associations ##
  ################################
  has_and_belongs_to_many :books

  attr_accessible :name
  
  validates_presence_of :name
  
end
