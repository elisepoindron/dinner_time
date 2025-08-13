module Api
  module V1
    class RecipesController < ApplicationController
      def index
        if params[:ingredients].present?
          @recipes= Recipe.search_by_ingredients(params[:ingredients])
        else
          @recipes = Recipe.all
        end

        render locals: { recipes: @recipes }
      end

      def show
        @recipe = Recipe.find(params[:id])

        render locals: { recipe: @recipe }
      end
    end
  end
end
