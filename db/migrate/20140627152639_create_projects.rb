class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :html
      t.text :css

      t.timestamps
    end
  end
end
