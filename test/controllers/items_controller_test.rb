require 'test_helper'

describe ItemsController, "GET :index" do
	before do
		activate_authlogic
		UserSession.create users :tomashn
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

# XXX: test user signup
# XXX: test index is not accessible without login

describe ItemsController, "POST :create" do
	itemtext1 = "Do something really awesome!"
	itemtext2 = ""

	before do
		activate_authlogic
		UserSession.create users :tomashn
	end

	it "stores new todo item in the database" do
		assert_difference 'Item.count' do
			post :create, :newitem => { :name => itemtext1 }
		end

		item = Item.last
		assert_equal itemtext1, item.name
	end

	it "responds with no action" do
		assert_no_difference 'Item.count' do
			post :create, :newitem => { :name => itemtext2 }
		end
	end
end
