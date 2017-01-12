module GameDecorator
  def get_all_active
  	self.where(is_deleted: 0)
  end
end

class Game < ApplicationRecord
  has_many :rental
  validates :title, presence: true,
                    length: { minimum: 5 }

  extend GameDecorator
end
