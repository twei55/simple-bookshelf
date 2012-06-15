# encoding : utf-8

class BooksController < ApplicationController

	before_filter :authenticate_user_or_admin, :only => [:index, :show]
	before_filter :authenticate_admin!, :only => [:new, :create, :edit, :update, :destroy]
	before_filter :delete_tag_in_use_fragment, :only => [:create, :update, :destroy]
	before_filter :delete_new_authors_from_params_hash, :only => [:create, :update]

	def index
		@books = Book.filter(params)
		@current_tag_id = params[:book] ? params[:book][:tag].to_i : 0
	end

	def show
		@book = Book.find(params[:id])
	end

	def new
		@book = Book.new
		@book.authors.build
	end

	def create
		@book = Book.new(params[:book])

		if params[:book][:format_ids]
			@book.formats << Format.find(params[:book][:format_ids])
		end
    
    if params[:book][:nested_tag_ids]
    	begin
    		@book.nested_tags << NestedTag.find(params[:book][:nested_tag_ids])
    	rescue ActiveRecord::RecordNotFound
    		puts "Ignored tag that can´t be found"
    	end
    end

    if (@book.save)
    	flash[:notice] = I18n.t("sb.flash.notices.create_book_success")
      redirect_to books_path
    else
    	flash[:error] = I18n.t("sb.flash.errors.create_book_error")
      @book.authors.build
      render :action => "new"
    end
	end

	def edit
    @book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		
		unless (@book.nil?)
      @book.update_attributes(params[:book])
		end

    if params[:book][:format_ids]
    	@book.formats.clear
    	@book.formats << Format.find(params[:book][:format_ids])
    end
    
    if params[:book][:nested_tag_ids]
    	@book.nested_tags.clear
    	begin
    		@book.nested_tags << NestedTag.find(params[:book][:nested_tag_ids])
    	rescue ActiveRecord::RecordNotFound
    		puts "Ignored tag that can´t be found"
    	end
    end

    if (@book.save)
    	flash[:notice] = I18n.t("sb.flash.notices.update_book_success")
      redirect_to books_path
    else
    	flash[:error] = I18n.t("sb.flash.errors.update_book_error")
      render :action => "edit"
    end

	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy

		flash[:notice] = I18n.t("sb.flash.notices.delete_book_success")
		redirect_to books_path
	end

	def destroy_document
		@book = Book.find(params[:id])
		@book.document = nil
		@book.save(:validate => false)
		
		flash[:notice] = I18n.t("sb.flash.notices.delete_attachment_success")
		redirect_to edit_book_path(@book)
	end
  
  #####
  # Actions beyond REST
  
  def similar
    @books = Book.similar_title(params[:title])
    render :template => "books/similar", :layout => false
  end
  
  private
  
  def delete_tag_in_use_fragment
    expire_fragment(:controller => "books", 
    	:action => "new", 
    	:action_suffix => 'tag_in_use_selection')
  end

  def delete_new_authors_from_params_hash
  	params["book"]["authors_attributes"].delete("new_authors")
  end

	protected

	def authenticate_user_or_admin
		unless user_signed_in? or admin_signed_in?
			redirect_to new_user_session_path 
		end
	end
end
