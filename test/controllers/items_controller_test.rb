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

		it "assigns a new todo item to @item" do
			assigns(:newitem).wont_be_nil
		end
	end

	describe "POST :create" do
		describe "with valid attributes" do
			itemtext = "Do something really awesome!"
			numitems = 0

			before do
				numitems = Item.count
				post :create, newitem: { name: itemtext }
			end

			it "stores new todo item in the database" do
				expect(Item.count).must_equal numitems+1

				item = Item.last
				assert_equal itemtext, item.name
			end
		end

		describe "with invalid attributes" do
			itemtext = ""
			numitems = 0

			before do
				numitems = Item.count
				post :create, newitem: { name: itemtext }
			end

			it "responds with no action" do
				assert_equal numitems, Item.count
			end
		end
	end
end
