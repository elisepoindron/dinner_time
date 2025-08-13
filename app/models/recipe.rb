class Recipe < ApplicationRecord
  validates :name, presence: true

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  include PgSearch::Model

  pg_search_scope :search_by_ingredients,
    associated_against: { ingredients: :name },
    using: {
       tsearch: {
        dictionary: "english",
        prefix: true
         } }
end
