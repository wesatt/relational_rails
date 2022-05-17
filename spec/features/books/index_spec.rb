require 'rails_helper'

RSpec.describe "Books index page" do
  describe "User Story 3, Child Index" do
    # As a visitor
    # When I visit '/child_table_name'
    # Then I see each Child in the system including the Child's attributes:
    it "can display the name and attributes of each Book" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      # book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      # book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      visit '/books'

      expect(page).to have_content(book1.id)
      expect(page).to have_content(book1.name)
      expect(page).to have_content(book1.has_foreword)
      expect(page).to have_content(book1.pages)
      expect(page).to have_content(book1.created_at)
      expect(page).to have_content(book1.updated_at)
      expect(page).to have_content(book1.author_id)
      # expect(page).to have_content(book2.name)
      expect(page).to have_content(book3.name)
      # expect(page).to have_content(book4.name)
    end
  end

  describe "User Story 8, Child Index Link & User Story 9, Parent Index Link" do
    let(:author1) { Author.create!(name: "Stephen King", still_active: true, age: 74) }
    let(:author2) { Author.create!(name: "Jen Gunter", still_active: true, age: 55) }
    let(:book1) { Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1) }
    let(:book2) { Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id) }
    let(:book3) { author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100) }
    let(:book4) { author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200) }
    let(:spec_site_path) { "/books" }

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

  describe "User Story 15, Child Index only shows `true` Records" do
    # As a visitor
    # When I visit the child index
    # Then I only see records where the boolean column is `true`
    it "only shows books with a foreword" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      visit '/books'

      expect(page).to have_content(book1.name)
      expect(page).to have_content(book3.name)

      expect(page).to_not have_content(book2.name)
      expect(page).to_not have_content(book4.name)
    end
  end

  describe "User Story 18, Child Update From Childs Index Page (part 1 of 2)" do
    # As a visitor
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    # Next to every child, I see a link to edit that child's info
    # When I click the link
    # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 11
    it "each book has a link to edit that book's info" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)

      visit "/books"

      within "#book-#{book5.id}" do
        expect(page).to have_link("Update Book")

        click_link "Update Book"

        expect(current_path).to eq("/books/#{book5.id}/edit")
      end
    end
  end

  describe "User Story 23, Child Delete From Childs Index Page" do
    # As a visitor
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    # Next to every child, I see a link to delete that child
    # When I click the link
    # I should be taken to the `child_table_name` index page where I no longer see that child
    it "can delete a specific book through a link" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: true, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "It", has_foreword: true, pages: 450, author_id: author1.id)

      visit "/books"

      expect(page).to have_content("The Stand")

      within "#book-#{book2.id}" do
        click_link "Delete Book"
      end

      expect(current_path).to eq("/books")
      expect(page).to_not have_content("The Stand")
    end
  end

  describe "Non User Story Functionality" do
    # As the person writing code
    # when I visit the child index
    # I can click on the book names and they are links to take me to their respective show page
    it "has links to the show page" do
      author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
      author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
      book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
      book2 = Book.create!(name: "The Stand", has_foreword: true, pages: 200, author_id: author1.id)
      book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
      book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
      book5 = Book.create!(name: "IT", has_foreword: true, pages: 450, author_id: author1.id)

      visit "/books"

      expect(page).to have_content("The Gunslinger")
      expect(page).to have_content("The Stand")
      expect(page).to have_content("IT")

      within "#book-#{book2.id}" do
        click_link book2.name
      end

      expect(current_path).to eq("/books/#{book2.id}")
      expect(page).to have_content("The Stand")
      expect(page).to_not have_content("The Gunslinger")
      expect(page).to_not have_content("IT")
    end
  end
end
