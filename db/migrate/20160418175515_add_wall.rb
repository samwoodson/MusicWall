class AddWall < ActiveRecord::Migration
  def change 
    create_table :posts do |t|
      t.string :title
      t.string :artist
      t.string :song
      t.timestamps null: false
    end
  end
end
