# encoding: utf-8
require 'spec_helper'

describe "visit all pages" do

	let(:admin) { FactoryGirl.create(:admin, :group => Group.first) }

  it "raises no errors when visiting pages" do
  	visit new_user_session_path
		fill_in("user_email", :with => admin.email)
		fill_in("user_password", :with => admin.password)
		click_button("Einloggen")

		expect {visit books_path}.to_not raise_error
		expect {visit new_book_path}.to_not raise_error
		expect {visit keywords_path}.to_not raise_error
		expect {visit formats_path}.to_not raise_error
  end



end