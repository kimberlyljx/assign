class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |d|
      d.belongs_to :user, index:true
      d.string :name
      d.integer :round_count
      d.timestamps null: false
    end
  end
end
