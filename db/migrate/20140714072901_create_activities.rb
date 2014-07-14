class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :action
      t.integer :user_id
      t.integer :other_id
      t.integer :leaf_id

      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, :other_id
    add_index :activities, :leaf_id
    add_index :activities, [:leaf_id, :other_id, :user_id], unique: true
  end
end
