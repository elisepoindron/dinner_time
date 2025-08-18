require 'rails_helper'

RECIPE_AMOUNT = 50

def json_response
  JSON.parse(response.body)
end

def response_data
  json_response["data"]
end

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    let!(:recipes) { create_list(:recipe, RECIPE_AMOUNT) }

    it "returns the expected recipe" do
      favorite = create(:recipe, name: "Favorite recipe")

      get "/api/v1/recipes/#{favorite.id}"

      expect(response).to have_http_status(:ok)
      expect(json_response["id"]).to eq(favorite.id)
    end

    it "returns all recipes" do
      get "/api/v1/recipes?items_per_page=#{10000}"

      expect(response).to have_http_status(:ok)
      expect(response_data.length).to eq(RECIPE_AMOUNT)
    end

    context "when filtering by ingredients" do
      it "returns only matching recipes" do
        liver = create(:ingredient, name: "liver")
        favorite = create(:recipe, name: "Favorite recipe")
        create(:recipe_ingredient, recipe: favorite, ingredient: liver)

        get "/api/v1/recipes?ingredients=liver"

        expect(response).to have_http_status(:ok)
        expect(response_data).to contain_exactly(a_hash_including("id" => favorite.id, "name" => "Favorite recipe"))
        expect(response_data[0]["id"]).to eq(favorite.id)
      end

      it "ignores wrong parameters" do
        get "/api/v1/recipes?items_per_page=#{RECIPE_AMOUNT}&wrong_param=liver"

        expect(response).to have_http_status(:ok)
        expect(response_data.length).to eq(RECIPE_AMOUNT)
      end
    end

    context "with pagination" do
      it "uses default items per page" do
        get "/api/v1/recipes"

        expect(response).to have_http_status(:ok)
        expect(response_data.length).to eq(Kaminari.config.default_per_page)
      end

      it "returns the total count" do
        get "/api/v1/recipes"

        expect(response).to have_http_status(:ok)
        expect(json_response["total_count"]).to eq(RECIPE_AMOUNT)
      end

      it "respects custom items per page" do
        items_per_page = 15

        get "/api/v1/recipes?items_per_page=#{items_per_page}"

        expect(response).to have_http_status(:ok)
        expect(response_data.length).to eq(items_per_page)
      end
    end
  end
end
