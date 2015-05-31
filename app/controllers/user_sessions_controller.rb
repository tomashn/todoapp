class UserSessionsController < ApplicationController
	before_action :authenticate, :only => :destroy

	def new
		if current_user then redirect_to root_path end
		@user_session = UserSession.new
	end

	def create
		params_session = user_session_params

		@user_session = UserSession.new(params_session)
		if @user_session.save
			redirect_to root_path
		else
			if User.find_by :email => params_session[:email].downcase
				render :action => :new
			else
				# sign up user
				@user = User.new(params_session.merge( :password_confirmation => params_session[:password] ) )
				@user.save
				redirect_to root_path
			end
		end
	end

	def destroy
		current_user_session.destroy
		redirect_to root_path
	end

	private

		def user_session_params
			params.require(:user_session).permit(:email, :password)
		end
end
