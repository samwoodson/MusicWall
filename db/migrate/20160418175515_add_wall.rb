class AddWall < ActiveRecord::Migration
  def change 
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :link
      t.timestamps null: false
    end
  end
end
