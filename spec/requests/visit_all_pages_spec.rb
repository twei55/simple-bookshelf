# encoding: utf-8
require 'spec_helper'

describe "visit all pages" do

	before(:all) do
    @admin = FactoryGirl.create(:admin)
  end

  it "raises no errors when visiting pages" do
  	visit new_admin_session_path
		fill_in("admin_email", :with => @admin.email)
		fill_in("admin_password", :with => @admin.password)
		click_button("Einloggen")

		expect {visit books_path}.to_not raise_error
		expect {visit new_book_path}.to_not raise_error
		expect {visit keywords_path}.to_not raise_error
		expect {visit formats_path}.to_not raise_error
  end



end