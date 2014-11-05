class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :big_oven_recipe_id
      t.string :title
      t.string :description
      t.string :web_url
      t.string :image_url
      t.integer :star_rating
      t.integer :review_count
      t.text :instructions
      t.integer :yield_number

      t.integer :order_id
      t.timestamps null: false
    end
  end
end
