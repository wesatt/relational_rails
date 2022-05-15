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

  describe "User Story 8, Child Index Link & User Story 9, Parent Index Link" do
    let(:author1) { Author.create!(name: "Stephen King", still_active: true, age: 74) }
    let(:author2) { Author.create!(name: "Jen Gunter", still_active: true, age: 55) }
    let(:book1) { Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1) }
    let(:book2) { Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id) }
    let(:book3) { author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100) }
    let(:book4) { author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200) }
    let(:spec_site_path) { "/authors" }

    it "has a link to Books#index (User Story 8)" do
      # As a visitor
      # When I visit any page on the site
      # Then I see a link at the top of the page that takes me to the Child Index
      visit spec_site_path

      click_link "Books Home"

      expect(current_path).to eq("/books")
    end

    it "has a link to Authors#index (User story 9)" do
      # As a visitor
      # When I visit any page on the site
      # Then I see a link at the top of the page that takes me to the Parent Index
      visit spec_site_path

      click_link "Authors Home"

      expect(current_path).to eq("/authors")
    end
  end

  describe "User Story 11, Parent Creation (part 1 of 2)" do
    # As a visitor
    # When I visit the Parent Index page
    # Then I see a link to create a new Parent record, "New Parent"
    # When I click this link
    # Then I am taken to '/parents/new' where I  see a form for a new parent record
    it "has a link to create a new Author that takes you to Authors#new" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      visit '/authors'

      expect(page).to have_content("New Author")

      click_link "New Author"

      expect(current_path).to eq("/authors/new")
      # User story continued in new_spec.rb
    end
  end
end
