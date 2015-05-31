class ItemsController < ApplicationController
	before_action :authenticate

	def index
		@items = Item.all
		@newitem = Item.new
	end

	def create
		@item = Item.new(newitem_params.merge( :category => 1 ))

		respond_to do |format|
			if @item.save
				format.html { redirect_to :action => :index }
				format.js {}
				# format.json { render json: @item, status: :created, location: @item }
			else
				index
				format.html { render :action => :index }
				# format.json { render json: @item.errors, status: :unprocessable_entry }
			end
		end
	end

	private

		def newitem_params
			params.require(:newitem).permit(:name)
		end
end
