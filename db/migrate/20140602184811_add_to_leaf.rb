class AddToLeaf < ActiveRecord::Migration
  def change
  	add_column :leafs, :embed_code, :text
  	add_column :leafs, :thumbnail_url, :string
  end
end
