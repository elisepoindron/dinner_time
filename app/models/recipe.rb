class Recipe < ApplicationRecord
  validates :name, presence: true

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients


  # J'avoue ça c'est généré par chatGPT ahah faut que j'approndisse le "comment ça marche" pour savoir de quoi je parle mais ça marche
  scope :search_by_ingredients, ->(query) {
  joins(:ingredients).merge(Ingredient.search_by_name(query))
}
end
