class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password
      t.string :email
      t.timestamps null: false
    end
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :link
      t.timestamps null: false
      t.references :user
    end
  end
end
