class CreateUserFavs < ActiveRecord::Migration
  def change
    create_table :user_favs do |t|
      t.integer :user_id
      t.integer :leaf_id

      t.timestamps
    end
 	add_index :user_favs, [:user_id, :leaf_id], :unique => true
  end
end
