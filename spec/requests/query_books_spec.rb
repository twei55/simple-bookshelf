# encoding: utf-8
require 'spec_helper'

describe "query" do

	let(:admin) { FactoryGirl.create(:admin, :group => Group.first) }
	let(:user) { FactoryGirl.create(:user, :group => Group.first) }

	before(:each) do
    visit new_user_session_path
		fill_in("user_email", :with => admin.email)
		fill_in("user_password", :with => admin.password)
		click_button("Einloggen")
  end

	it "performs some queries" do
		fill_in("query", :with => "Uwe Timm")
		click_button("Suche")

		page.should have_content("Die Erfindung der Currywurst")
		page.should have_content("Am Beispiel meines Bruders")
		page.should_not have_content("Mona Lisa Overdrive")

		fill_in("query", :with => "Erfindung")
		click_button("Suche")
		page.should have_content("Die Erfindung der Currywurst")
		page.should have_content("Die Erfindung der Bratwurst")
		page.should_not have_content("Am Beispiel meines Bruders")
	end

end