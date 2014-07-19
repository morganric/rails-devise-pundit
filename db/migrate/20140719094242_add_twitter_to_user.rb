class AddTwitterToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_token, :string
    add_column :users, :twitter_secret, :string
  end

  # add_index :users, [:twitter_secret, :twitter_token], :unique => true
end
