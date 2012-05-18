# encoding: utf-8
require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the BooksHelper. For example:
#
# describe BooksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe BooksHelper do
  
  describe '#add_post_params' do

  	it "adds post params to url 1" do
  		params = {"query" => "Foo", "choices" => {
  			"author" => "1", "publisher" => "1", "title" => "1"},
  			"book" => {"tag" => "123", "format" => "456"},
  			"sort" => 'title', "order" => "asc"
  		}

  		res = helper.add_post_params(params)
  		res.should == "&order=desc&query=Foo&choices[author]=1&choices[publisher]=1&choices[title]=1&book[tag]=123&book[format]=456"
  	end

  	it "adds post params to url 2" do
  		params = {"query" => "Bar", "choices" => {"author" => "1"},
  			"book" => {"tag" => "123"},
  			"sort" => 'publisher', "order" => "desc"
  		}

  		res = helper.add_post_params(params)
  		res.should == "&order=asc&query=Bar&choices[author]=1&book[tag]=123"
  	end

    it "adds post params to url 3" do
      params = ActiveSupport::HashWithIndifferentAccess.new
      params["utf8"] = "1"
      params["query"] = "" 
      params["commit"] = "Suche"
      params["book"] = ActiveSupport::HashWithIndifferentAccess.new
      params["book"]["format"] = "11" 
      params["book"]["tag"] = "51"
      
      res = helper.add_post_params(params)
      res.should == "&order=asc&utf8=1&query=&book[format]=11&book[tag]=51"
    end

  end

  describe '#add_order_arrow' do

  	context "Search direction ASC" do

  		it "adds correct arrow image" do
  			params = {"order" => "asc", "sort" => "title"}
  			res = helper.add_order_arrow('title', params)
  			res.include?("/images/icons/bullet_arrow_up.png").should be_true
  			res.include?("Sortierung absteigend").should be_true
  		end

  	end

  	context "Search direction DESC" do

			it "adds correct arrow image" do
  			params = {"order" => "desc", "sort" => "title"}
  			res = helper.add_order_arrow('title', params)
  			res.include?("/images/icons/bullet_arrow_down.png").should be_true
  			res.include?("Sortierung aufsteigend").should be_true
  		end

  	end

  end

  context "Tree select" do

  	describe '#tree_select' do

      it "returns select tag with list of indented options" do
        res = helper.tree_select([@tag4], "book", "tags", -1, 0, {:multiple => false, :filter_unused => true})
        res.include?("select").should be_true
        res.include?("multiple").should be_false
      end

      it "returns multiple select tag" do
        res = helper.tree_select([@tag4], "book", "tags", -1, 0, {:multiple => true, :filter_unused => false})
        res.include?("multiple").should be_true
      end

    end

    describe '#add_options' do

      it "appends all tags to an array" do
        res = helper.add_options([@tag4], -1)
        res.should == [
          ["&#160;#{@tag4.name}", @tag4.id.to_s], 
          ["&#160;&#160;&#160;#{@tag1.name}", @tag1.id.to_s], 
          ["&#160;&#160;&#160;#{@tag2.name}", @tag2.id.to_s],
          ["&#160;&#160;&#160;#{@tag3.name}", @tag3.id.to_s]
        ]
      end

    end

  end

	describe '#display_category' do
  end

	describe '#display_nested_tags' do
  end

	describe '#display_linked_authors' do

    it "returns a list of links" do
      authors = [FactoryGirl.create(:timm), FactoryGirl.create(:gibson)]
      res = helper.display_linked_authors(authors)
      res.should include("/books?query=Gibson&amp;choices[author]=1&amp;choices[publisher]=1")
      res.should include("/books?query=Timm&amp;choices[author]=1&amp;choices[publisher]=1")
      res.should include("Gibson, William</a>")
      res.should include("Timm, Uwe</a>")
    end

  end

	describe '#display_formats' do
  end

  describe '#display_number' do

  end

end