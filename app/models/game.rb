class Game < ApplicationRecord
  has_many :rental
  validates :title, presence: true,
                    length: { minimum: 5 }
end
