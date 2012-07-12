# encoding: utf-8

require 'spec_helper'

describe "create book" do

	let(:admin) { FactoryGirl.create(:admin, :group => Group.first) }
  let(:user) { FactoryGirl.create(:user, :group => Group.first) }

	before(:each) do
    visit new_user_session_path
		fill_in("user_email", :with => admin.email)
		fill_in("user_password", :with => admin.password)
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
