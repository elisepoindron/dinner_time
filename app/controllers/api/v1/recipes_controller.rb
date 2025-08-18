module Api
  module V1
    class RecipesController < ApplicationController
      def index
        ingredients, page, items_per_page, sort_by= recipes_params.values_at(:ingredients, :page, :items_per_page, :sort_by)

        sort_query= []
        sort_by ? sort_by.each { |key, value| sort_query.unshift("#{key} #{value}") } : nil

        @recipes = Recipe.order(sort_query)
        .page(page)
        .per(items_per_page)

        @recipes= @recipes.search_by_ingredients(ingredients) if ingredients.present?

        render locals: { recipes: @recipes, total_count: @recipes.total_count }
      end

      def show
        @recipe = Recipe.find(params[:id])

        render locals: { recipe: @recipe }
      end

      # Only allow a list of trusted parameters through.
      def recipes_params
        params.permit({ sort_by: {} }, :items_per_page, :page, :ingredients)
      end
    end
  end
end
