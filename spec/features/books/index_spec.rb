require 'rails_helper'

RSpec.describe "Books index page" do
  describe "User Story 3, Child Index" do
    # As a visitor
    # When I visit '/child_table_name'
    # Then I see each Child in the system including the Child's attributes:
    it "can display the name and attributes of each Book" do
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200)
      book3 = Book.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = Book.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      visit '/books'

      # save_and_open_page
      expect(page).to have_content(book1.id)
      expect(page).to have_content(book1.name)
      expect(page).to have_content(book1.has_foreword)
      expect(page).to have_content(book1.pages)
      expect(page).to have_content(book1.created_at)
      expect(page).to have_content(book1.updated_at)
      # expect(page).to have_content(book1.author_id)
      expect(page).to have_content(book2.name)
      expect(page).to have_content(book3.name)
      expect(page).to have_content(book4.name)
    end
  end
end
