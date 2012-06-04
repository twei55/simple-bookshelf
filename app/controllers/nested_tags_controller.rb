# encoding: utf-8

class NestedTagsController < ApplicationController

	before_filter :authenticate_admin!
  before_filter :delete_tags_fragment, :only => [:create, :update,:destroy]
  before_filter :delete_tags_in_use_fragment, :only => [:update,:destroy]

  def index
  	@nested_tag = NestedTag.new
  end
  
  def create
    @nested_tag = NestedTag.new(params[:nested_tag])
    @nested_tag.parent_id = 0 if params[:nested_tag][:parent_id].blank?
    if (@nested_tag.save)
      flash[:notice] = "Neues Schlagwort wurde angelegt."
    else
      flash[:notice] = "Neues Schlagwort konnte nicht angelegt werden."
    end
    redirect_to keywords_path
  end
  
  def update
    begin
      @nt = NestedTag.find(params[:book][:nested_tag_ids][0])
      @nt.update_attributes(params[:nested_tag])
      flash[:notice] = "Schlagwort wurde aktualisiert."
      redirect_to keywords_path
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Schlagwort konnte nicht aktualisiert werden."
      redirect_to keywords_path      
    end
  end
  
  def destroy
    begin
      @nt = NestedTag.find(params[:book][:nested_tag_ids][0])
      @nt.destroy
      flash[:notice] = "Schlagwort(e) wurde gelöscht."
      redirect_to keywords_path
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Schlagwort(e) konnte nicht gelöscht werden."
      redirect_to keywords_path      
    end
  end
  
  private
  
  def delete_tags_fragment
    expire_fragment(:controller => "nested_tags", 
      :action => "new", 
      :action_suffix => 'tag_selection')
  end
  
  def delete_tags_in_use_fragment
    expire_fragment(:controller => "books", 
      :action => "new", 
      :action_suffix => 'tag_in_use_selection')
  end
  
end
