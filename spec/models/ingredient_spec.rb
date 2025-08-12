require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context "on creation" do
    it "does not save without name" do
      ingredient = FactoryBot.build(:ingredient, name: nil)
      expect(ingredient).to_not be_valid
    end

    it "does not save redundant ingredients" do
      ingredient = FactoryBot.create(:ingredient)
      duplicate_ingredient = FactoryBot.build(:ingredient)

      expect(ingredient).to  be_valid
      expect(duplicate_ingredient).to_not be_valid
    end
  end
end
