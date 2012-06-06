class Author < ActiveRecord::Base

	################################
  ### ActiveRecord Associations ##
  ################################
  
  has_many :book_authors
  has_many :books, :through => :book_authors
  
  ################################
  ### ActiveRecord Validations  ##
  ################################
  
  # validates_presence_of :first_name, :message => "Bitte gib einen Vornamen an"
  validates_presence_of :last_name, :message => "Bitte gebe einen Nachnamen an"
  
  #############
  # Hooks
  #############

  before_save :set_full_name, :set_full_name_reversed

  def set_full_name
    if first_name.present?
      self[:full_name] = "#{first_name} #{last_name}"
    else
      self[:full_name] = "#{last_name}"
    end
  end

  def set_full_name_reversed
    if first_name.present?
      self[:full_name_reversed] = "#{last_name}, #{first_name}"
    else
      self[:full_name_reversed] = "#{last_name}"
    end
  end

  def self.find_or_create(first,last)
    find_by_first_name_and_last_name(first,last) || create(:first_name => first,:last_name => last)
  end
  
end
