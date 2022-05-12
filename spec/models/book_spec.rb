require "rails_helper"

RSpec.describe Book, type: :model do
  describe "Table and relationships" do
    describe "relationship" do
      it { should belong_to :author }
    end

    describe "Table validations" do
      it { should validate_presence_of :name }
      it { should validate_presence_of :pages }
      it { should allow_value(true).for(:has_foreword) }
      it { should allow_value(false).for(:has_foreword) }
    end
  end
end
