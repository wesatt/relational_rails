require "rails_helper"

RSpec.describe Book, type: :model do
  describe "Table and relationships" do
    it {should belong_to :author}

    it { should validate_presence_of :name }
    it { should validate_presence_of :has_foreword }
    it { should validate_presence_of :pages }
  end
end
