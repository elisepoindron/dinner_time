module Api
  class RecipesController < ApplicationController
    def index
      @recipes = Recipe.all

      render locals: { recipes: @recipes }
    end

    def show
      render locals: { recipe: @recipe }
    end
  end
end
