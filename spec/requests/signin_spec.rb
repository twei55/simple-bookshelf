# encoding: utf-8
require 'spec_helper'

describe "signin" do

	let(:admin) { FactoryGirl.create(:admin, :group => Group.first) }
	let(:user) { FactoryGirl.create(:user, :group => Group.first) }

	it "signs me in as admin" do
		visit new_user_session_path
		fill_in("user_email", :with => admin.email)
		fill_in("user_password", :with => admin.password)
		click_button("Einloggen")

		find('ul.nav li', :text => "Suche")
		find('ul.nav li', :text => "Titel anlegen")
		find('ul.nav li', :text => "Schlagwörter")
		find('ul.nav li', :text => "Publikationsarten")
		find('ul.nav li', :text => "Ausloggen")
	end

	it "signs me in as user" do
		visit new_user_session_path
		fill_in("user_email", :with => user.email)
		fill_in("user_password", :with => user.password)
		click_button("Einloggen")

		expect {find('ul.nav li', :text => "Titel anlegen")}.to raise_exception(Capybara::ElementNotFound)
		expect {find('ul.nav li', :text => "Schlagwörter")}.to raise_exception(Capybara::ElementNotFound)
		expect {find('ul.nav li', :text => "Publikationsarten")}.to raise_exception(Capybara::ElementNotFound)
		find('ul.nav li', :text => "Suche")
		find('ul.nav li', :text => "Ausloggen")
	end

end