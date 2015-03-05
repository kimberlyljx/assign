class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |g|
      g.belongs_to :card, index:true
      g.string :correct, :wrong
    end
  end
end
