# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



puts "Seeding database"

json = File.read('db/recipes.json')
parsed_recipes = JSON.parse(json)

if !Ingredient.exists?
  puts "Seeding ingredients"

  ingredients = parsed_recipes.flat_map { |recipe| recipe["ingredients"] }.uniq
  ingredients.each { |ingredient| Ingredient.create({ name: ingredient }) }

  puts "#{ingredients.length} ingredients seeded"

end

if !Recipe.exists?
  puts "Seeding recipes"

  parsed_recipes.each do |recipe|
    Recipe.create({
          name: recipe["title"],
          cooking_time: recipe["cook_time"],
          preparation_time: recipe["prep_time"],
          ingredients: recipe["ingredients"],
          rating: recipe["ratings"],
          cuisine: recipe["cuisine"],
          category: recipe["category"],
          author: recipe["author"],
          image_url: recipe["image"]
        })
  end

  puts "#{parsed_recipes.length}  recipes seeded"
end
