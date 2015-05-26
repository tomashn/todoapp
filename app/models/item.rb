class Item < ActiveRecord::Base
	validates :name, presence: true, allow_blank: false
	validates :category, presence: true
end
