# encoding: utf-8

require 'spec_helper'

describe "create, update, delete keywords" do

	let(:admin) { FactoryGirl.create(:admin) }
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
    visit new_admin_session_path
		fill_in("admin_email", :with => admin.email)
		fill_in("admin_password", :with => admin.password)
		click_button("Einloggen")
  end

	it "creates a new keyword" do
		visit keywords_path

		within("div#new-keyword-form") do
			fill_in("nested_tag_name", :with => "Exklusion")
		end

		click_button("Schlagwort hinzufügen")
		find("#nested_tag_parent_id").has_text?("Exklusion").should be_true

		within("div#update-keyword-form") do
			find("#book_nested_tag_ids").has_text?("Exklusion").should be_true
		end
	end

	it "updates an existing keyword" do
		visit keywords_path

		within("div#update-keyword-form") do
			select('Exklusion', :from => "book_nested_tag_ids")
			fill_in("nested_tag_name", :with => 'Ausschluß')
		end

		click_button("Schlagwort aktualisieren")
		find("#nested_tag_parent_id").has_text?("Ausschluß").should be_true

		within("div#update-keyword-form") do
			find("#book_nested_tag_ids").has_text?("Ausschluß").should be_true
		end
	end

	it "deletes an existing format" do
		visit keywords_path

		within("div#delete-keyword-form") do
			select('Ausschluß', :from => "book_nested_tag_ids")
			click_button("Schlagwort löschen")
		end

		find("#nested_tag_parent_id").has_text?("Ausschluß").should be_false
		
		within("div#update-keyword-form") do
			find("#book_nested_tag_ids").has_text?("Ausschluß").should be_false
		end
	end

end