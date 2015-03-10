class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |c|
      c.belongs_to :deck, index:true
      c.string :english
      c.string :other
    end
  end
end
