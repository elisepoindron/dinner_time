# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


return if Recipe.exists?

puts "Seeding database"

json = File.read('db/recipes.json')
parsed_recipes = JSON.parse(json)

parsed_recipes.each do |recipe|
  created_recipe = Recipe.create({
        name: recipe["title"],
        cooking_time: recipe["cook_time"],
        preparation_time: recipe["prep_time"],
        rating: recipe["ratings"],
        cuisine: recipe["cuisine"],
        category: recipe["category"],
        author: recipe["author"],
        image_url: recipe["image"]
      })

  ingredients = recipe["ingredients"]
  ingredients.each do |ingredient|
    created_ingredient = Ingredient.find_or_create_by(name: ingredient)

    RecipeIngredient.create({
      recipe_id: created_recipe[:id],
      ingredient_id: created_ingredient[:id]
    })
  end
end

puts "#{parsed_recipes.length}  recipes seeded"
