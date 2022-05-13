require "rails_helper"

RSpec.describe Author, type: :model do
  describe "relationship" do
    it { should have_many :books }
  end

  describe "Table validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should allow_value(true).for(:still_active) }
    it { should allow_value(false).for(:still_active) }
  end

  describe "class methods" do
    it "sorts by created time" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)

      expect(Author.order_by_created_time).to eq([author2, author1])
    end
  end
end
