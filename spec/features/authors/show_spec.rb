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

      expect(page).to have_content(author1.name)
      expect(page).to have_content("Count of Books: 3")
    end
  end

  describe "User Story 8, Child Index Link & User Story 9, Parent Index Link" do
    let(:author1) { Author.create!(name: "Stephen King", still_active: true, age: 74) }
    let(:author2) { Author.create!(name: "Jen Gunter", still_active: true, age: 55) }
    let(:book1) { Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1) }
    let(:book2) { Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id) }
    let(:book3) { author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100) }
    let(:book4) { author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200) }
    let(:spec_site_path) { "/authors/#{author1.id}" }

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

  describe "User Story 10, Parent Child Index Link" do
    # As a visitor
    # When I visit a parent show page ('/parents/:id')
    # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
    it "has a link to the Authors list of books (authors/:id/books)" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      visit "/authors/#{author1.id}"

      expect(page).to have_content("Books By #{author1.name}")

      click_link "Books By #{author1.name}"

      expect(current_path).to eq("/authors/#{author1.id}/books")
    end
  end

  describe "User Story 12, Parent Update (part 1 of 2)" do
    # As a visitor
    # When I visit a parent show page
    # Then I see a link to update the parent "Update Parent"
    # When I click the link "Update Parent"
    # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
    it "has a link to Authors#edit" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)

      visit "/authors/#{author1.id}"
      click_link "Update Author"

      expect(current_path).to eq("/authors/#{author1.id}/edit")
      # User story continued in edit_spec.rb
    end
  end

  describe "User Story 19, Parent Delete" do
    # As a visitor
    # When I visit a parent show page
    # Then I see a link to delete the parent
    # When I click the link "Delete Parent"
    # Then a 'DELETE' request is sent to '/parents/:id',
    # the parent is deleted, and all child records are deleted
    # and I am redirected to the parent index page where I no longer see this parent
    it "can delete a parent" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)

      visit "/books"

      expect(page).to have_content("The Gunslinger")
      expect(page).to have_content("The Vagina Bible")

      visit "/authors"

      expect(page).to have_content("Stephen King")

      visit "/authors/#{author1.id}"

      click_link "Delete Author"

      expect(current_path).to eq("/authors")
      expect(page).to_not have_content("Stephen King")

      visit "/books"

      expect(page).to_not have_content("The Gunslinger")
      expect(page).to_not have_content("The Stand")
      expect(page).to_not have_content("It")
      expect(page).to have_content("The Vagina Bible")
    end
  end
end
