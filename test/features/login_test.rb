require "test_helper"

feature "Login - user is not logged in" do
	before do
		visit login_path
		page.must_have_css "#fg-login"
	end

	scenario "user enters invalid email" do
		within "#fg-login" do
			fill_in "user_session[email]", :with => "test"
			fill_in "user_session[password]", :with => "pass"
			click_button "login-btn"
		end
		page.current_path.must_equal login_path
		# XXX: test display of correct error message
	end

	scenario "user enters email which do not exist in database and some password" do
		within "#fg-login" do
			fill_in "user_session[email]", :with => "test@aditi.sk"
			fill_in "user_session[password]", :with => "pass"
			click_button "login-btn"
		end
		page.current_path.must_equal root_path
	end

	scenario "user enters email which does not exist in database and no password" do
		within "#fg-login" do
			fill_in "user_session[email]", :with => "test1@aditi.sk"
			fill_in "user_session[password]", :with => ""
			click_button "login-btn"
		end
		page.current_path.must_equal login_path
		# XXX: test display of correct error message
	end

	scenario "user enters email which exists in database and incorrect password" do
		within "#fg-login" do
			fill_in "user_session[email]", :with => "test@aditi.sk"
			fill_in "user_session[password]", :with => "p"
			click_button "login-btn"
		end
		page.current_path.must_equal login_path
		# XXX: test display of correct error message
	end
end

feature "Login" do
	before do
		visit login_path
		fill_in "user_session[email]", :with => users(:tomashn).email
		fill_in "user_session[password]", :with => "pass"
		click_button "login-btn"
		visit login_path
	end

	scenario "user is logged in" do
			page.current_path.must_equal root_path
	end
end
