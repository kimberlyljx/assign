class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |r|
      r.belongs_to :deck
      r.integer :total_guess, :default => 0
      r.integer :total_card, :default => 0
      r.integer :total_correct, :default => 0
      r.integer :total_incorrect, :default => 0
      r.timestamps null: false
    end
  end
end
