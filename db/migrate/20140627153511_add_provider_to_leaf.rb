class AddProviderToLeaf < ActiveRecord::Migration
  def change
    add_column :leafs, :provider, :string
  end
end
