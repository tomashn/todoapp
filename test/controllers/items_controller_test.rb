require 'test_helper'

describe "ItemsController" do
	describe "GET :index" do
		before do
			get :index
		end

		it "renders items/index" do
			must_render_template "items/index"
		end

		it "responds with success" do
			must_respond_with :success
		end

		it "fetches and assigns a list of todo items" do
			assigns(:items).wont_be_nil

			item_ids = assigns(:items).map(&:id).sort
			item_ids.must_equal Item.pluck(:id).sort
		end
	end
end
