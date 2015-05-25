require 'test_helper'

describe "Item" do
	before do
		@item = Item.new name: "Awesome name."
	end

	it "has a name attribute" do
		@item.must_respond_to :name
	end
end
