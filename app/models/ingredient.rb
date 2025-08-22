class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  include PgSearch::Model

  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: {
        dictionary: "english",
        prefix: true,
        any_word: true,
        tsvector_column: "search_vector"
      }
    }
end
