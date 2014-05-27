class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.text :bio
      t.string :image
      t.string :website
      t.date :date_of_birth
      t.string :location
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
