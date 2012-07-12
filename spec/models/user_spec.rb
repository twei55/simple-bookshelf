require 'spec_helper'

describe User do

	describe '.add_to_group' do

		let(:group) {FactoryGirl.create(:group1)}
		let(:user) {FactoryGirl.build(:user)}

		context "group name given" do

			it "creates a new group and adds user to it" do
				params = {"group" => {"id" => "", "name" => "Neue Gruppe"}}
				user.add_to_group(params["group"])

				user.group.should_not be_nil
				user.group.name.should == "Neue Gruppe"
				user.admin?.should be_true
			end

		end

		context "group id given" do

			it "adds user to an existing group" do
				params = {"group" => {"id" => group.id, "name" => ""}}
				user.add_to_group(params["group"])

				user.group.should == group
				user.group.name.should == "Gruppe 1"
				user.admin?.should be_false
			end

		end

		context "group name and id given" do

			it "does not add user to a group" do
				params = {"group" => {"id" => group.id, "name" => "Neue Gruppe"}}
				user.add_to_group(params["group"])
				user.valid?.should be_false
			end

		end

	end
  
end
