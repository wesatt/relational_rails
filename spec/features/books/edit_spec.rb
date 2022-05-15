require 'rails_helper'

RSpec.describe "Books edit page" do
  describe "User Story 14, Child Update (part 2 of 2)" do
    # When I click the button to submit the form "Update Child"
    # Then a `PATCH` request is sent to '/child_table_name/:id',
    # the child's data is updated,
    # and I am redirected to the Child Show page where I see the Child's updated information
    it "has a link to update the Book information" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      book2 = Book.create!(name: "The Stan", has_foreword: false, pages: 200, author_id: author1.id)

      visit "/books/#{book2.id}"

      expect(page).to_not have_content("The Stand")
      expect(page).to have_content("The Stan")

      visit "/books/#{book2.id}/edit"

      fill_in(:name, with: 'The Stand')
      fill_in(:has_foreword, with: false)
      fill_in(:pages, with: 200)
      click_button('Update Book')

      expect(current_path).to eq("/books/#{book2.id}")
      expect(page).to have_content("The Stand")
    end
  end
end
