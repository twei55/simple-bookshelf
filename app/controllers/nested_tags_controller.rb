# encoding: utf-8

class NestedTagsController < ApplicationController

	before_filter :authenticate_admin
  before_filter :delete_tags_fragment, :only => [:create, :update,:destroy]
  before_filter :delete_tags_in_use_fragment, :only => [:update,:destroy]

  def index
  	@nested_tag = NestedTag.new
  end
  
  def create
    @nested_tag = NestedTag.new(params[:nested_tag])
    @nested_tag.parent_id = 0 if params[:nested_tag][:parent_id].blank?
    if (@nested_tag.save)
      flash[:notice] = I18n.t("sb.flash.notices.create_tag_success")
    else
      flash[:error] = I18n.t("sb.flash.errors.create_tag_error")
    end
    
    redirect_to keywords_path
  end
  
  def update
    if (params[:book] && params[:book][:nested_tag_ids])
      @nt = NestedTag.find(params[:book][:nested_tag_ids][0])
      @nt.update_attributes(params[:nested_tag])
      flash[:notice] = I18n.t("sb.flash.notices.update_tag_success")
    else
      flash[:error] = I18n.t("sb.flash.errors.update_tag_error")
    end

    redirect_to keywords_path
  end
  
  def destroy
    if (params[:book] && params[:book][:nested_tag_ids])
      @nt = NestedTag.find(params[:book][:nested_tag_ids][0])
      @nt.destroy
      flash[:notice] = I18n.t("sb.flash.notices.delete_tag_success")
    else
      flash[:error] = I18n.t("sb.flash.errors.delete_tag_error")
    end

    redirect_to keywords_path
  end
  
  private
  
  def delete_tags_fragment
    expire_fragment(:controller => "books", 
      :action => "new", 
      :action_suffix => 'tag_selection')
  end
  
  def delete_tags_in_use_fragment
    expire_fragment(:controller => "books", 
      :action => "new", 
      :action_suffix => 'tag_in_use_selection')
  end
  
end
