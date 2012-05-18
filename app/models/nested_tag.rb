class NestedTag < ActiveRecord::Base

	acts_as_tree :order => "name"
  
  ################################
  ### ActiveRecord Associations ##
  ################################
  
  has_and_belongs_to_many :books, :join_table => "books_nested_tags"
  
  validates_presence_of :name
  
  scope :root, :conditions => ["parent_id = ?",0], :order => "LOWER(name) ASC"
  
	scope :sorted, :order => "LOWER(name) ASC"
  
  scope :in_use, :select => "DISTINCT nested_tags.*", :joins => :books, :order => "name ASC"

end
