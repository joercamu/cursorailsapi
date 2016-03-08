class CreateMyObjects < ActiveRecord::Migration
  def change
    create_table :my_objects do |t|
      t.string :title
      t.text :description
      t.float :latitude
      t.float :longitude
      t.float :reward
      t.string :name_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end