class AddTwitterToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :twitter_handle, :string
  end
end
