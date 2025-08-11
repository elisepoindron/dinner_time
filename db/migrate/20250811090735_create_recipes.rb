class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :cooking_time
      t.integer :preparation_time
      t.decimal :rating
      t.string :cuisine
      t.string :category
      t.string :author
      t.string :image_url
      t.string :ingredients

      t.timestamps
    end
  end
end
