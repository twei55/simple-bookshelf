# encoding: utf-8

require 'spec_helper'

describe "create, update, delete formats" do

	let(:admin) { FactoryGirl.create(:admin) }
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
    visit new_admin_session_path
		fill_in("admin_email", :with => admin.email)
		fill_in("admin_password", :with => admin.password)
		click_button("Einloggen")
  end

	it "creates a new format" do
		visit formats_path

		within("div#new-format-form") do
			fill_in("format_name", :with => "Exklusion")
		end

		click_button("Hinzufügen")
		find("#format-id-update").has_text?("Exklusion").should be_true
		find("#format-id-delete").has_text?("Exklusion").should be_true
	end

	it "updates an existing format" do
		visit formats_path

		select('Dossier', :from => "format-id-update")
		within("div#update-format-form") do
			fill_in("format_name", :with => 'New name')
		end

		click_button("Aktualisieren")
		find("#format-id-update").has_text?("New name").should be_true
		find("#format-id-delete").has_text?("New name").should be_true
	end

	it "deletes an existing format" do
		visit formats_path

		select('New name', :from => "format-id-delete")
		click_button("Löschen")
		find("#format-id-update").has_text?("New name").should be_false
		find("#format-id-delete").has_text?("New name").should be_false
	end

end