# Decorator module allowing to add new functionality to Game object without altering its structure
module GameDecorator
  # Get all active games (where is_deleted flag is NULL)
  def get_all_active
  	self.where(is_deleted: 0)
  end
end

# Game class describing game objects
class Game < ApplicationRecord
  has_many :rental
  validates :title, presence: true,
                    length: { minimum: 5 }

  extend GameDecorator
end
