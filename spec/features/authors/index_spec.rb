require 'rails_helper'

RSpec.describe "Authors index page" do
  describe "User Story 1, Parent Index" do
    # For each parent table
    # As a visitor
    # When I visit '/parents'
    # Then I see the name of each parent record in the system
    it "can display the name of each Author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      visit '/authors'

      # save_and_open_page
      expect(page).to have_content(author1.name)
      expect(page).to have_content(author2.name)
    end
  end

  describe "User Story 6, Parent Index sorted by Most Recently Created" do
    # As a visitor
    # When I visit the parent index,
    # I see that records are ordered by most recently created first
    # And next to each of the records I see when it was created
    it "displays the name of each Author in the descending order created" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      visit '/authors'

      # save_and_open_page
      expect("Jen Gunter").to appear_before("Stephen King")
      expect(page).to have_content(author1.name)
      expect(page).to have_content(author2.name)
      expect(page).to have_content(author1.created_at)
      expect(page).to have_content(author2.created_at)
    end
  end
end
