# encoding: utf-8

class Book < ActiveRecord::Base

	################################
  ### ActiveRecord Associations ##
  ################################

  has_many :book_authors
  has_many :authors, :through => :book_authors

  has_many :entries
  has_many :groups, :through => :entries

  accepts_nested_attributes_for :authors,
    :reject_if => :has_no_author_or_publisher?, :allow_destroy => true

  has_and_belongs_to_many :nested_tags, :join_table => "books_nested_tags"
  has_and_belongs_to_many :formats


  ###############
  # Validations
  ###############

  validates_presence_of :title, :message => I18n.t("sb.book.validations.title_missing")
  validates_presence_of :year, :message =>  I18n.t("sb.book.validations.year_missing")
  validates_presence_of :publisher, :message => I18n.t("sb.book.validations.publisher_missing")
  validates_presence_of :authors, :message => I18n.t("sb.book.validations.author_missing")

  validates_associated :authors, :message => I18n.t("sb.book.validations.author_missing")

  # validates_attachment_content_type :document, :content_type => ['application/pdf'],
  # :allow_blank => true, :message => I18n.t("sb.book.validations.attachment_content_type")

  ###############
  # Scopes
  ###############

  default_scope :order => "title ASC"

  # Attention
  # Works only with tables of type = MyISAM
  scope :similar_title, lambda {|terms|
    terms = terms.split(" ").join(" +").insert(0,"+")
    {
    :select => "id,title",
    :conditions => ["MATCH (title) AGAINST (? IN BOOLEAN MODE)",terms]
    }
  }

  ##############
  # Paperclip
  ##############

  has_attached_file :document,
    :url => "/system/books/documents/:id/original/:basename.:extension",
    :path => ":rails_root/public/system/books/documents/:id/original/:basename.:extension"

  ##############
  # Thinking Sphinx
  ##############

  self.per_page = 20

  define_index do
  	indexes title, :sortable => true
  	indexes publisher, :sortable => true
  	indexes authors(:first_name), :as => :author_first_name, :sortable => true
  	indexes authors(:last_name), :as => :author_last_name, :sortable => true
    indexes authors(:full_name), :as => :author_full_name
    indexes authors(:full_name_reversed), :as => :author_full_name_reversed, :sortable => true
  	indexes formats.id, :as => :format_id
  	indexes nested_tags.id, :as => :tag_id
    indexes groups.id, :as => :group_id

    has year

    set_property :delta => true
  end

  #
  # Copy publisher name to author last name
  # and check if attribute is blank
  def has_no_author_or_publisher?(author)
    author["last_name"] = self.publisher if self.publisher_is_author
    author["last_name"].blank?
  end

  class << self

    def add_conditions(params, user)
    	conditions = {}
    	conditions[:tag_id] = params[:book][:tag] if params[:book] && params[:book][:tag].present?
    	conditions[:format_id] = params[:book][:format] if params[:book] && params[:book][:format].present?
      conditions[:group_id] = user.group_id

    	return conditions
    end

    def build_query_string(params)
      return "" if params[:query] && params[:query].strip.eql?("")
      fields = []

      if params[:choices] && Book.is_selected?(params[:choices][:author])
        fields = ["@author_first_name", "@author_last_name", "@author_full_name", "@author_full_name_reversed"]
      end

      fields << "@title" if params[:choices] && Book.is_selected?(params[:choices][:title])
      fields << "@publisher" if params[:choices] && Book.is_selected?(params[:choices][:publisher])

      fields.present? ? fields.join(" \"#{params[:query]}\" | ") + " \"#{params[:query]}\"" : params[:query]
    end

    def filter(params, user)
      result = Book.search(
                        build_query_string(params),
                        :page => params[:page] || 1,
                        :per_page => 20,
                        :sort_mode => params[:order] ? params[:order].to_sym : :asc,
                        :order => params[:sort] ? params[:sort].to_sym : :author_last_name,
                        :match_mode => :extended,
                        :conditions => add_conditions(params, user)
                        )
      return result
    end

    def is_selected?(choice)
    	choice && choice.eql?("1")
    end

  end
end
