require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create(:recipe, id: 1, name: "Favorite recipe")
      FactoryBot.create(:recipe, id: 2, name: "Least favorite recipe")
    end


    it "returns the expected recipe" do
      get "/api/v1/recipes/1"
      expect(JSON.parse(response.body)["id"]).to equal(1)
    end

    it "returns all recipes" do
      get "/api/v1/recipes"
      expect(JSON.parse(response.body).length).to equal(2)
    end

    describe "with ingredient filtering" do
      before do
        FactoryBot.create(:ingredient, id: 1, name: "liver")
        FactoryBot.create(:ingredient, id: 2, name: "chocolate")
        FactoryBot.create(:recipe_ingredient, recipe_id: 1, ingredient_id: 2)
        FactoryBot.create(:recipe_ingredient, recipe_id: 2, ingredient_id: 1)
      end

      it "filters the recipes" do
        get "/api/v1/recipes?ingredients=liver"
        response_body = JSON.parse(response.body)
        expect((response_body).length).to equal(1)
        expect(response_body[0]["id"]).to equal(2)
      end

      it "doesn't take into account wrong parameters" do
        get "/api/v1/recipes?wrong_param=liver"
        expect(JSON.parse(response.body).length).to equal(2)
      end
    end
  end
end
