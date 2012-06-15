# encoding: utf-8

class FormatsController < ApplicationController

	def index
		@format = Format.new
	end

	def create
		@format = Format.new(params[:format]) if Format.find_by_name(params[:format][:name]).nil?
		if (!@format.nil? && @format.save)
			flash[:notice] = I18n.t("sb.flash.notices.create_format_success")
		else
			flash[:error] = I18n.t("sb.flash.errors.create_format_error")
		end

    redirect_to formats_path
	end
  
  def update
    begin
      @format = Format.find(params[:format][:id])
      @format.update_attributes(params[:format])
      flash[:notice] = I18n.t("sb.flash.notices.update_format_success")
      redirect_to formats_path
    rescue ActiveRecord::RecordNotFound
      flash[:error] = I18n.t("sb.flash.errors.update_format_error")
      redirect_to formats_path    
    end
  end
  
  def destroy
    begin
      @format = Format.find(params[:format][:id])
      @format.destroy
      flash[:notice] = I18n.t("sb.flash.notices.delete_format_success")
      redirect_to formats_path
    rescue ActiveRecord::RecordNotFound
      flash[:error] = I18n.t("sb.flash.errors.delete_format_error")
      redirect_to formats_path      
    end
  end

end
