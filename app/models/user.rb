class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  belongs_to :group

  validates_presence_of :group, :message => I18n.t("sb.user.validations.group_missing")

  def add_to_group(params)
  	return if params["id"].present? && params["name"].present?

    if params["id"] && params["id"].present?
  	 	self.group = Group.find(params["id"])
    end

    if params["name"] && params["name"].present?
  		group = Group.create(:name => params["name"])
		  self.group = group
      self.admin = true
    end
    
  end
end
