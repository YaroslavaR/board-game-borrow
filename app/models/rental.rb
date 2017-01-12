# Decorator for Rental model
module RentalDecorator
	# Get all rentals - ordered by start_time DESC
	def get_all
	  	self.all.sort_by(&:start_time).reverse
	end

	# Get rental by id
	def get_by_id(id)
		self.find(id)
	end

	# Get all rentals for given user - ordered by start_time DESC
	def get_all_for_user(user)
		user.rental.sort_by(&:start_time).reverse
	end

	# Get non-vetoed reservation for particular game at a given day
	def get_non_vetoed_for(game_id, start_time)
		self.find_by(game_id: game_id, start_time: start_time, is_vetoed: nil)
	end

	# Get all user reservations for given day
	def get_for_user_and_date(user, date)
		user.rental.where(start_time: date)
	end
end

class Rental < ApplicationRecord
  	belongs_to :game
  	belongs_to :user

  	extend RentalDecorator
end



