require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "on creation" do
    it "does not save without name" do
      recipe = FactoryBot.build(:recipe, name: nil)
      expect(recipe).to_not be_valid
    end
  end
end
