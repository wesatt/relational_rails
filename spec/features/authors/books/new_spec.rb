require 'rails_helper'

RSpec.describe "Author books new page" do
  describe "User Story 13, Parent Child Creation (part 2 of 2)" do
    # When I fill in the form with the child's attributes:
    # And I click the button "Create Child"
    # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
    # a new child object/row is created for that parent,
    # and I am redirected to the Parent Childs Index page where I can see the new child listed
    it "creates a new book for the given author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      visit "/authors/#{author1.id}/books"

      expect(page).to_not have_content("IT")

      visit "/authors/#{author1.id}/books/new"

      fill_in(:name, with: 'IT')
      # fill_in(:has_foreword, with: true)
      select("true", from: :has_foreword)
      fill_in(:pages, with: 450)
      click_button('Add Book')

      expect(current_path).to eq("/authors/#{author1.id}/books")
      expect(page).to have_content("IT")
    end
  end
end
