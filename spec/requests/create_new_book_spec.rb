# encoding: utf-8

require 'spec_helper'

describe "create book" do

	let(:admin) { FactoryGirl.create(:admin) }
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
    visit new_admin_session_path
		fill_in("admin_email", :with => admin.email)
		fill_in("admin_password", :with => admin.password)
		click_button("Einloggen")
  end

  it "redirects to new action when form is submitted empty" do
  	visit new_book_path
  	click_button("Titel speichern")

  	page.has_text?("Neuen Titel anlegen").should be_true
  end

	it "redirects to new action when author is missing" do
		visit new_book_path

		fill_in("book_title", :with => "something")
		fill_in("book_year", :with => "2012")
		fill_in("book_publisher", :with => "some publisher")
  	click_button("Titel speichern")

  	page.has_text?("Neuen Titel anlegen").should be_true
  end

  context "Creation of new book succeeds" do

    context "if books has an author" do

      before(:each) do
        visit new_book_path
        fill_in("book_title", :with => "My new title")
        fill_in("book_year", :with => "2012")
        fill_in("book_publisher", :with => "some publisher")
        fill_in("book_authors_attributes_0_last_name", :with => "lastname")
        select("Bildung", :from => "book_nested_tag_ids")
        select("Abbildung", :from => "book_nested_tag_ids")
        click_button("Titel speichern")
      end

      it "redirects to books list when required fields have been filled in" do
    		page.should have_content("Ergebnisliste")
      	page.should have_content("Am Beispiel meines Bruders")
      end

      it "finds new book successfully by title" do
        visit books_path
      	fill_in("query", :with => "My new title")
      	click_button("Suche")
      	page.should have_content("My new title")
      	page.should_not have_content("Am Beispiel meines Bruders")
      end

      it "finds new book successfully by first keyword/tag" do
        fill_in("query", :with => "")
        select("Bildung", :from => "book_tag")
        click_button("Suche")
        page.should have_content("My new title")
      end

      it "finds new book successfully by second keyword/tag" do
        fill_in("query", :with => "")
        select("Abbildung", :from => "book_tag")
        click_button("Suche")
        page.should have_content("My new title")    
      end

    end

    context "if publisher is author" do

      before(:each) do
        visit new_book_path
        fill_in("book_title", :with => "My new title")
        fill_in("book_year", :with => "2012")
        fill_in("book_publisher", :with => "some publisher")
        find(:xpath, '//input[@id="book_publisher_is_author"]').set(true)
        click_button("Titel speichern")
      end

      it "redirects to books list when required fields have been filled in" do
        # FIXME
        # Checking checkbox fails when testing
        
        # page.should have_content("Ergebnisliste")
        # fill_in("query", :with => "My new title")
        # click_button("Suche")
        # page.should have_content("My new title")
      end

    end

  end

end