class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :username, :password
      u.timestamps null: false
    end
  end
end
