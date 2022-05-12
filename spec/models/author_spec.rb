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
end
