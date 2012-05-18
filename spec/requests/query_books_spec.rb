# encoding: utf-8
require 'spec_helper'

describe "query" do

	let(:admin) { FactoryGirl.create(:admin) }
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
    visit new_admin_session_path
		fill_in("admin_email", :with => admin.email)
		fill_in("admin_password", :with => admin.password)
		click_button("Einloggen")
  end

	it "performs some queries" do
		visit new_user_session_path
		fill_in("user_email", :with => user.email)
		fill_in("user_password", :with => user.password)
		click_button("Einloggen")

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