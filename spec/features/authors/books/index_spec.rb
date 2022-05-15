require 'rails_helper'

RSpec.describe "Author books index" do
  describe "User Story 5, Parent Children Index" do
    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes:
    it "displays the name and attributes of all books by a specific author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)

      visit "/authors/#{author1.id}/books"

      # save_and_open_page
      expect(page).to have_content(book1.id)
      expect(page).to have_content(book1.name)
      expect(page).to have_content(book1.has_foreword)
      expect(page).to have_content(book1.pages)
      expect(page).to have_content(book1.created_at)
      expect(page).to have_content(book1.updated_at)
      expect(page).to have_content(book1.author_id)
      expect(page).to have_content(book2.name)

      expect(page).to_not have_content(book3.name)
      expect(page).to_not have_content(book4.name)
    end
  end

  describe "User Story 8, Child Index Link & User Story 9, Parent Index Link" do
    let(:author1) { Author.create!(name: "Stephen King", still_active: true, age: 74) }
    let(:author2) { Author.create!(name: "Jen Gunter", still_active: true, age: 55) }
    let(:book1) { Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1) }
    let(:book2) { Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id) }
    let(:book3) { author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100) }
    let(:book4) { author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200) }
    let(:spec_site_path) { "/authors/#{author1.id}/books" }

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

  describe "User Story 13, Parent Child Creation" do
    # As a visitor
    # When I visit a Parent Childs Index page
    # Then I see a link to add a new adoptable child for that parent "Create Child"
    # When I click the link
    # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child

    # When I fill in the form with the child's attributes:
    # And I click the button "Create Child"
    # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
    # a new child object/row is created for that parent,
    # and I am redirected to the Parent Childs Index page where I can see the new child listed
    it "has a link to add a new book to the author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      visit "/authors/#{author1.id}/books"

      expect(page).to have_link("Add Book")

      click_link "Add Book"

      expect(current_path).to eq("/authors/#{author1.id}/books/new")
    end

    it "creates a new book for the given author" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      visit "/authors/#{author1.id}/books"

      expect(page).to_not have_content("The Gunslinger")

      visit "/authors/#{author1.id}/books/new"

      fill_in(:name, with: 'The Gunslinger')
      fill_in(:has_foreword, with: true)
      fill_in(:pages, with: 100)
      click_button('Add Book')

      expect(current_path).to eq("/authors/#{author1.id}/books")
      expect(page).to have_content("The Gunslinger")
    end
  end
end
