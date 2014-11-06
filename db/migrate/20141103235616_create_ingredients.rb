class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :quantity
      t.string :unit

      t.integer :recipe_id
      t.timestamps null: false
    end
  end
end
