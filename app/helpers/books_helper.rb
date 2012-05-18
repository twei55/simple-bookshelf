# encoding: utf-8

module BooksHelper
  
  # Taken from Railscast #197
  # http://railscasts.com/episodes/197-nested-model-form-part-2?view=asciicast
  def add_new_author_fields(f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
    end
  end

  def add_post_params(params)
    blackList = ["action", "controller", "order", "sort", "commit"]
    url_params = params["order"] && params["order"].downcase.eql?("asc") ? "&order=desc" : "&order=asc"  
    url_params += append(params, blackList)
    return url_params
  end

  def append(args, blackList, objectname = nil)
    str = ""
    args.each do |key, value|
      unless blackList.include?(key)
        if value.class.eql?(Hash) || value.class.eql?(ActiveSupport::HashWithIndifferentAccess)
          str += append(value, blackList, key)
        else
          if objectname
            str += "&#{objectname}[#{key}]=#{value}"
          else
            str += "&#{key}=#{value}"
          end
        end
      end
    end

    return str
  end
  
  def add_order_arrow(sort, params)
    if (params["sort"] && params["sort"].eql?(sort))
      (params["order"] && params["order"].present? && params["order"].downcase.eql?("asc")) ? image_tag("icons/bullet_arrow_up.png",:title=>"Sortierung absteigend") : image_tag("icons/bullet_arrow_down.png",:title=>"Sortierung aufsteigend") 
    end
  end


  # # Tree select
  # # @params
  # # filter_unused = Show only tags that are used by at least one book
  # #

  def tree_select(categories, model, name, level=-1, selected="", options={})
    option_tags = [["-- Bitte auswählen --", ""]]
    option_tags = option_tags + add_options(categories, level, options)

    select_options = {:id => "#{model}_#{name}"}
    select_options[:multiple] = options[:multiple] || false

    select_tag("#{model}[#{name}]", 
      options_for_select(option_tags, selected.to_s), 
      select_options
    )
  end

  #
  # Add all available categories and its children to an array
  #
  def add_options(categories, level, options={})
    option_tags = []

    if categories.length > 0
      level += 1 # keep position
      categories.collect do |cat|
        if display_category(cat, options)
          # Indentation
          indent = ""
          (0..level*2).each do |i|
            indent << "&#160;"
          end

          option_tags << [indent.html_safe + cat.name, cat.id.to_s]

          if cat.children.any?
            option_tags = option_tags + add_options(cat.children, level, options)
          end
        end

      end

    end

    option_tags
  end
  
  def display_category(cat, options={})
    return true unless options[:filter_unused]
    
    show = cat.books.size > 0
    if cat.parent_id = 0
      cat.children.each do |subcat| 
        show = subcat.books.size > 0
        break if show
      end
    end
    
    return show
  end
  
  def display_nested_tags(tags)
    li_tags = ""
    for tag in tags
      unless tag.parent.nil?
        li_tags << content_tag(:li, "#{tag.parent.name} > ")
      end
      li_tags << content_tag(:li) do
        link_to tag.name, books_path + "?query=&book[tag]=" + tag.id.to_s + "&choices[author]=1", :title => "Suche nach Keyword '#{tag.name}'"
      end
    end

    content_tag(:ul, li_tags.html_safe, :class => "tags")
  end
  
  def display_linked_authors(authors)
    authors = authors.sort_by { |a| a.last_name.downcase }
    linked_authors = authors.map { |author|
      link_to(author.full_name_reversed, books_path + "?query=#{author.last_name}&choices[author]=1&choices[publisher]=1", :class => "author", :title => "Suche nach Autor '#{author.last_name}'")
    }
    linked_authors.any? ? linked_authors.join(", ").html_safe : ""
  end
  
  def display_formats(book)
    html = book.formats.collect{ |format| 
      link_to format.name, books_path + "?query=&book[format]=#{format.id}"
    }.sort.join(", ")
    html ? html.html_safe : "keine"
  end
  
  def display_number(i)
    params[:page] = 1 unless params[:page]
    (i+(Book.per_page*(params[:page].to_i-1))+1).to_s
  end
end
