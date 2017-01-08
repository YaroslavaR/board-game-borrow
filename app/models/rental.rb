module RentalDecorator
	def get_all
	  	self.all.sort_by(&:start_time).reverse
	end

	def get_by_id(id)
		self.find(id)
	end

	def get_all_for_user(user)
		user.rental.sort_by(&:start_time).reverse
	end

	def get_non_vetoed_for(game_id, start_time)
		self.find_by(game_id: game_id, start_time: start_time, is_vetoed: nil)
	end

	def get_for_user_and_date(user, date)
		user.rental.where(start_time: date)
	end
end

class Rental < ApplicationRecord
  	belongs_to :game
  	belongs_to :user

  	extend RentalDecorator
end



