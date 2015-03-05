class Deck < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :rounds
  has_many :cards
end
