require 'rails_helper'

RSpec.describe "Authors show page" do
  describe "User Story 2, Parent Show" do
    # As a visitor
    # When I visit '/parents/:id'
    # Then I see the parent with that id including the parent's attributes:
    # - data from each column that is on the parent table
    it "can show the name and attributes of a specific Author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      visit "/authors/#{author1.id}"

      # save_and_open_page
      expect(page).to have_content(author1.id)
      expect(page).to have_content(author1.name)
      expect(page).to have_content(author1.still_active)
      expect(page).to have_content(author1.age)
      expect(page).to have_content(author1.created_at)
      expect(page).to have_content(author1.updated_at)
      expect(page).to_not have_content(author2.name)
    end
  end

  describe "User Story 7, Parent Child Count" do
    # As a visitor
    # When I visit a parent's show page
    # I see a count of the number of children associated with this parent
    it "can show the count of books of a specific Author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      visit "/authors/#{author1.id}"

      save_and_open_page
      expect(page).to have_content(author1.name)
      expect(page).to have_content("Count of Books: 3")
    end
  end
end
