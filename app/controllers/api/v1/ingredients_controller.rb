module Api
  module V1
    class IngredientsController < ApplicationController
      def index
        @ingredients = Ingredient.all

        render locals: { ingredients: @ingredients }
      end

      def show
        @ingredient = Ingredient.find(params[:id])

        render locals: { ingredient: @ingredient }
      end
    end
  end
end
