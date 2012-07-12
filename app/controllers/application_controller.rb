class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
 
	def set_locale
  	I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {})
		{ :locale => I18n.locale }
	end

	def current_person
		current_user || current_admin
	end

	def authenticate_admin
    	unless user_signed_in? and current_user.admin?
    	  	redirect_to new_user_session_path 
    	end
  	end
	
end
