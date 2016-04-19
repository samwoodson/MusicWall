class Reviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :message
      t.references :song
      t.references :user
      t.timestamps null: false
    end
  end
end
