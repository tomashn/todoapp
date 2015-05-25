require "test_helper"

feature "Todolist" do
  scenario "display a list of todo items" do
    visit root_path
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
end
