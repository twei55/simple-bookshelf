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

  it "updates index successfully" do
  	visit edit_book_path(Book.first.id)
  	fill_in("book_title", :with => "My updated title")
  	select("Bildung", :from => "book_nested_tag_ids")
  	fill_in("book_authors_attributes_0_first_name", :with => "Arjen")
  	fill_in("book_authors_attributes_0_last_name", :with => "Robben")
  	click_button("Titel aktualisieren")

  	page.should have_content("My updated title")
  	page.should have_content("Robben, Arjen")
  end

 end
