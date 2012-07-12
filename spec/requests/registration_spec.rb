# encoding: utf-8

require 'spec_helper'

describe "registration process" do

	it "should redirect back to form if no group is selected" do
		visit new_user_registration_path
		fill_in("user_email", :with => "someone@localhost.com")
		fill_in("user_password", :with => "123xyz")
		fill_in("user_password_confirmation", :with => "123xyz")
		click_button("Registrieren")

		current_path.should == user_registration_path
		page.should have_content(I18n.t("sb.user.validations.group_missing"))
	end

	it "should redirect back to form if group is selected and group name is filled in" do
		visit new_user_registration_path
		fill_in("user_email", :with => "someone@localhost.com")
		fill_in("user_password", :with => "123xyz")
		fill_in("user_password_confirmation", :with => "123xyz")
		select("Gruppe 1", :form => "group_id")
		fill_in("group_name", :with => "Neue Gruppe")
		click_button("Registrieren")

		current_path.should == user_registration_path
		page.should have_content(I18n.t("sb.user.validations.group_missing"))
	end

	it "should register successfully when group is selected" do
		visit new_user_registration_path
		fill_in("user_email", :with => "someone@localhost.com")
		fill_in("user_password", :with => "123xyz")
		fill_in("user_password_confirmation", :with => "123xyz")
		select("Gruppe 1", :form => "group_id")
		click_button("Registrieren")

		current_path.should == new_user_session_path
	end

	it "should register successfully when group name is filled in" do
		visit new_user_registration_path
		fill_in("user_email", :with => "someone-else@localhost.com")
		fill_in("user_password", :with => "123xyz")
		fill_in("user_password_confirmation", :with => "123xyz")
		fill_in("group_name", :with => "Neue Gruppe")
		click_button("Registrieren")

		current_path.should == new_user_session_path
	end

end