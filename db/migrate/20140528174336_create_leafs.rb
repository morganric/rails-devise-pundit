class CreateLeafs < ActiveRecord::Migration
  def change
    create_table :leafs do |t|
      t.string :title
      t.text :copy
      t.string :image
      t.string :video
      t.string :audio
      t.string :url
      t.boolean :via_url
      t.boolean :live
      t.integer :plays
      t.integer :views
      t.integer :user_id
      t.string :type

      t.timestamps
    end
  end
end
