class ItemsController < ApplicationController
	def index
		@items = Item.all
		@newitem = Item.new
	end

	def create
		item = Item.new(newitem_params.merge( :category => 1 ))
		if item.save(item)
			redirect_to :action => :index
		else
			index
			render 'items/index'
		end
	end

	private

		def newitem_params
			params.require(:newitem).permit(:name)
		end
end
