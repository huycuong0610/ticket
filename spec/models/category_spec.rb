require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category){category = Category.new}
  describe "Validate" do
  	it "Check blank name" do
  		category.save
  		expect(category.errors).to_not be_empty
  	end
  end
end
