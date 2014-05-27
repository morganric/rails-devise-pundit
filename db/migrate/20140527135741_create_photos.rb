class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.boolean :public
      t.string :image
      t.text :description
      t.integer :user_id
      t.string :type
      t.integer :size
      t.string :slug
      t.integer :views

      t.timestamps
    end
  end
end
