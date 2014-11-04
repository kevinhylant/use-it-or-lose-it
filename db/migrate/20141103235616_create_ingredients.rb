class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :display_quantity
      t.string :unit
      t.text :preparation_notes

      t.integer :recipe_id
      t.timestamps null: false
    end
  end
end
