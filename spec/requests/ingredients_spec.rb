require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create(:ingredient, id: 1, name: "liver")
      FactoryBot.create(:ingredient, id: 2, name: "chocolate")
    end



    it "returns the expected ingredient" do
      get "/api/v1/ingredients/1"
      expect(JSON.parse(response.body)["id"]).to equal(1)
    end

    it "returns all ingredients" do
      get "/api/v1/ingredients"
      expect(JSON.parse(response.body).length).to equal(2)
    end
  end
end
