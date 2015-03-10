class Guess < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :card
end
