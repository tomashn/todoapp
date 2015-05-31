require "test_helper"

describe User do
	before do
		@user = User.new :email => "user@user.com", :password => "pass"
	end

  it "has an email attribute" do
		@user.must_respond_to :email
  end

	it "has a persistence_token attribute" do
		@user.must_respond_to :persistence_token
	end

	it "has a crypted_password attribute" do
		@user.must_respond_to :crypted_password
	end
end
