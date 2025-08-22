class Recipe < ApplicationRecord
  validates :name, presence: true

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  scope :search_by_ingredients, ->(query) {
  joins(:ingredients).merge(Ingredient.search_by_name(query))
}
end
