class AddFeaturedToLeaf < ActiveRecord::Migration
  def change
    add_column :leafs, :featured, :boolean, :default => false
  end
end
