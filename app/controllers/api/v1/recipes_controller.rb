module Api
  module V1
    class RecipesController < ApplicationController
      def index
        if recipes_params[:ingredients].present?
          @recipes= Recipe.search_by_ingredients(recipes_params[:ingredients])
        else
          @recipes = Recipe.all
        end

        render locals: { recipes: @recipes }
      end

      def show
        @recipe = Recipe.find(params[:id])

        render locals: { recipe: @recipe }
      end

      # Only allow a list of trusted parameters through.
      def recipes_params
        params.permit(:ingredients)
      end
    end
  end
end
