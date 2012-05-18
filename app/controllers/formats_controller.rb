# encoding: utf-8

class FormatsController < ApplicationController

	def index
		@format = Format.new
	end

	def create
		@format = Format.new(params[:format]) if Format.find_by_name(params[:format][:name]).nil?
		if (!@format.nil? && @format.save)
			flash[:notice] = "Neue Publikationsart wurde angelegt."
		else
			flash[:notice] = "Neues Publikationsart konnte nicht angelegt werden.<br />Entweder sie haben keinen Namen eingegeben
                       oder eine Publikationsart mit gleichem Namen existiert bereits."
		end

    redirect_to formats_path
	end
  
  def update
    begin
      @format = Format.find(params[:format][:id])
      @format.update_attributes(params[:format])
      flash[:notice] = "Publikationsart wurde aktualisiert."
      redirect_to formats_path
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Publikationsart konnte nicht aktualisiert werden."
      redirect_to formats_path    
    end
  end
  
  def destroy
    begin
      @format = Format.find(params[:format][:id])
      @format.destroy
      flash[:notice] = "Publikationsart wurde gelöscht."
      redirect_to formats_path
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Publikationsart konnte nicht gelöscht werden."
      redirect_to formats_path      
    end
  end

end
