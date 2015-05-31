require "test_helper"

feature "Todolist" do
	scenario "user is not logged in" do
		visit root_path
		page.current_path.must_equal login_path
	end
end

feature "Todolist" do
	before do
		# create session
		visit root_path
		fill_in "user_session[email]", :with => users(:tomashn).email
		fill_in "user_session[password]", :with => "pass"
		click_button "login-btn"

		visit root_path
	end

	scenario "display a list of todo items" do
		page.must_have_css("#itemsrow")
		within("#itemsrow") do
			Item.find_each do |item|
				selector = "#item#{ item.id }"
				page.must_have_css(selector)
				within(selector) do
					page.must_have_content item.name
				end
			end
		end
	end

	scenario "insert a new todo item" do
		itemtext = "Do something really awesome!"

		page.must_have_css("#inputrow")
		within "#inputrow" do
			fill_in "newitem[name]", :with => itemtext
			click_button "save-btn"
		end
		within "#itemsrow" do
			page.must_have_content itemtext
		end
	end
end
