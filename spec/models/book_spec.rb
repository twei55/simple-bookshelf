# encoding: utf-8
require 'spec_helper'

describe Book do
  
  let(:user1) {
    FactoryGirl.create(:user, :group => Group.first)
  }
  let(:user2) {
    FactoryGirl.create(:user, :group => Group.last)
  }

  describe '.filter' do

    context "search" do

      it "returns only books of the user´s group" do
        params = {:query => "", 
          :choices => {:author => "1", :title => "1", :publisher => "1"}
        }
        result = Book.filter(params, user1)
        result.should have(10).item
      end

      it "does not return books when they don´t belong to the user´s group" do
        params = {:query => "",
          :choices => {:author => "1", :title => "1", :publisher => "1"}
        }
        result = Book.filter(params, user2)
        result.should have(0).item
      end

    end

  	context "search for title, author, publisher" do

      it "returns two books from author William Gibson and one book called William Gibson" do
        params = {:query => "Gibson",
          :choices => {:author => "1", :title => "1", :publisher => "1"}
        }
        result = Book.filter(params, user1)
        result.should have(3).item
      end

  	end

  	context "search for title, author" do

      it "returns 2 books with query term in title" do
        params = {:query => "Erfindung", 
          :choices => {:author => "1", :title => "1"},
          :book => {:format => "", :tag => ""}
        }
        result = Book.filter(params, user1)
        result.should have(2).item
      end

      it "returns 2 books with query term (special char) in title" do
        params = {:query => "Schlüssel", 
          :choices => {:author => "1", :title => "1"},
          :book => {:format => "", :tag => ""}
        }
        result = Book.filter(params, user1)
        result.should have(2).item
      end

  	end

  	context "search for title, publisher" do

      it "returns 2 books from dtv" do
        params = {:query => "dtv", 
          :choices => { :title => "1", :publisher => "1"}
        }
        result = Book.filter(params, user1)
        result.should have(2).item
      end

  	end

  	context "search for author, publisher" do

      it "returns 3 books from Haruki Murakami" do
        params = {:query => "Haruki", 
          :choices => {:author => "1", :publisher => "1"},
          :book => {:format => "", :tag => ""}
        }
        result = Book.filter(params, user1)
        result.should have(3).item
      end

  	end

  	context "search for author only" do

      context "last name" do
      
        it "returns 2 books" do
          params = {:query => "Timm", 
            :choices => {:author => "1"}
          }
          result = Book.filter(params, user1)
          result.should have(2).item
        end

      end

      context "full name" do
        
        it "returns 2 books" do
          params = {:query => "Uwe Timm", 
            :choices => {:author => "1"}
          }
          result = Book.filter(params, user1)
          result.should have(2).item
        end

      end

      context "full name in opposite order" do

        it "returns 2 books" do
          params = {:query => "Timm, Uwe",
            :choices => {:author => "1"}
          }
          result = Book.filter(params, user1)
          result.should have(2).item
        end

    	end

    end

		context "search for publisher only" do

      it "returns 5 books from Suhrkamp" do
        params = {:query => "Suhrkamp", 
          :choices => {:publisher => "1"}
        }
        result = Book.filter(params, user1)
        result.should have(5).item
      end

  	end

  	context "search for title only" do

      it "returns one book called William Gibson" do
        params = {:query => "Gibson", 
          :choices => {:title => "1"}
        }
        result = Book.filter(params, user1)
        result.should have(1).item
      end

  	end

    context "search for tag" do

      it "returns three books tagged with 'Alleinerziehende'" do
        params = {:query => "", 
          :book => {:tag => NestedTag.find_by_name("Alleinerziehende").id}
        }
        result = Book.filter(params, user1)
        result.should have(3).item
      end

      it "returns one book tagged with 'Science'" do
        params = {:query => "Mister Aufziehvogel", 
          :choices => {:title => "1"}, 
          :book => {:tag => NestedTag.find_by_name("Science").id}
        }
        result = Book.filter(params, user1)
        result.should have(1).item
      end

    end

    context "search for format" do

    end
  
  end

  describe ".build_query_string" do

    it "includes author, title and publisher in query" do
      params = {:query => "Gibson", 
        :choices => {
          :author => "1", :title => "1", :publisher => "1"
        }
      }
      query_string = Book.build_query_string(params)
      query_string.should == '@author_first_name "Gibson" | @author_last_name "Gibson" | @author_full_name "Gibson" | @author_full_name_reversed "Gibson" | @title "Gibson" | @publisher "Gibson"'
    end

    it "includes author and title in query" do
      params = {:query => "ABC", 
        :choices => {:author => "1", :title => "1"}
      }
      query_string = Book.build_query_string(params)
      query_string.should == '@author_first_name "ABC" | @author_last_name "ABC" | @author_full_name "ABC" | @author_full_name_reversed "ABC" | @title "ABC"'
    end

    it "includes author in query" do
      params = {:query => "William Gibson", 
        :choices => {:author => "1"}
      }
      query_string = Book.build_query_string(params)
      query_string.should == "@author_first_name \"William Gibson\" | @author_last_name \"William Gibson\" | @author_full_name \"William Gibson\" | @author_full_name_reversed \"William Gibson\""
    end

  end

  describe '.add_conditions' do

    it "adds tag_id field to condition hash" do
      params = {:query => "", :book => {:tag => "1"}}
      conditions = Book.add_conditions(params, user1)

      conditions.should have(2).item
      conditions.should have_key(:tag_id)
    end

    it "adds format_id field to condition hash" do
      params = {:query => "", :book => {:format => "1"}}
      conditions = Book.add_conditions(params, user1)

      conditions.should have(2).item
      conditions.should have_key(:format_id)
    end

    it "adds tag_id and format_id field to condition hash" do
      params = {:query => "", :book => {:tag => "1", :format => "1"}}
      conditions = Book.add_conditions(params, user1)

      conditions.should have(3).items
    end

    
  end

  describe '.get_similar_titles' do

  end

  context "Creation of books" do

    describe 'validation' do

      it "makes sure entry is not valid without an author" do
        params = {"book" => {
          "title" => "Test",
          "year" => "2010",
          "publisher" => "dtv",
          "authors_attributes" => {"0" =>
              {"first_name" => "", "last_name" => "", "_destroy"=>"false"}
            }
          }
        }
        book = Book.new(params["book"])
        book.valid?.should be_false
      end

      it "makes sure entry is valid when publisher is author" do
        params = {"book" => {
          "title" => "Test",
          "year" => "2010",
          "publisher" => "dtv",
          "publisher_is_author" => true,
          "authors_attributes" => {"0" =>
              {"first_name" => "", "last_name" => "", "_destroy"=>"false"}
            }
          }
        }
        book = Book.new(params["book"])
        book.valid?.should be_true
      end

    end

  end

end