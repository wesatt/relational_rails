require "rails_helper"

RSpec.describe Author, type: :model do
  describe "Table and relationships" do
    it {should have_many :books}

    it { should validate_presence_of :name }
    it { should validate_presence_of :still_active }
    it { should validate_presence_of :age }
  end
end
