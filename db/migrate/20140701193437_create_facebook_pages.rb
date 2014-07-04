class CreateFacebookPages < ActiveRecord::Migration
  def change
    create_table :facebook_pages do |t|
      t.integer :user_id
      t.string :fb_page_id

      t.timestamps
    end
    add_index :facebook_pages, [:user_id, :fb_page_id], :unique => true
  end
end
