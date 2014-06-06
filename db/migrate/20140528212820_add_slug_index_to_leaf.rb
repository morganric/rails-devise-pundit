class AddSlugIndexToLeaf < ActiveRecord::Migration
  def change
  	add_column :leafs, :slug, :string
  	add_index :leafs, :slug, :unique => true
  end
end
