require 'spec_helper'

describe BooksController do

	context "unauthorized" do

		context "GET index" do

			it "redirects to login page" do
				get :index
				response.should be_redirect
			end

		end

	end

	context "admin" do

		login_admin

		context "GET index" do

			it "renders index page" do
				get :index
				response.should be_success
				response.should render_template('index')
			end

		end

		context "GET new" do

			it "renders index page" do
				get :new
				response.should be_success
				response.should render_template('new')
			end

		end

	end

	context "user" do

		login_user

		context "GET index" do

			it "renders index page" do
				get :index
				response.should be_success
				response.should render_template('index')
			end

		end

		context "GET new" do

			it "renders index page" do
				get :new
				response.should be_redirect
			end

		end

	end

end
