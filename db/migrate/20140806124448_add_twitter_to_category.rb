class AddTwitterToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :twitter_token, :string
    add_column :categories, :twitter_secret, :string
    add_column :categories, :twitter_handle, :string
  end
end
