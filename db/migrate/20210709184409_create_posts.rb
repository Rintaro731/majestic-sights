class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :address, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :image_id, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
