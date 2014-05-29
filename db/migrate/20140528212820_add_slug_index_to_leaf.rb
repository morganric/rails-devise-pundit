class AddSlugIndexToLeaf < ActiveRecord::Migration
  def change
  	add_column :leafs, :slug, :strign
  	add_index :leafs, :slug, :unique => true
  end
end
