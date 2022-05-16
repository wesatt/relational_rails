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

  describe "instance methods" do
    it "author#books_count returns the count of books by a specific author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)

      expect(author1.books_count).to eq(3)
      expect(author2.books_count).to eq(2)
    end

    it "author#book_order(sort_order) returns books in the order specified by parameters" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)

      expect(author1.book_order(nil)).to eq([book1, book2, book5])
      expect(author1.book_order("Alphabetical")).to eq([book5, book1, book2])
      expect(author1.book_order("Literally anything else")).to eq([book1, book2, book5])
    end
  end
end
