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

  describe "class methods" do
    it "Book#with_foreword only has books with a foreword" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)

      expect(Book.with_foreword).to eq([book1, book3])
    end

    it "Book#site_order can return a list of books alphabetically" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)


      expect(author1.books.site_order("Alphabetical")).to eq([book5, book1, book2])
      expect(author1.books.site_order("Literally anything else")).to eq([book1, book2, book5])
    end
  end
end
