# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.destroy_all
Author.destroy_all

author1 = Author.create!(name: "Stephen King", still_active: true, age: 74)
author2 = Author.create!(name: "Jen Gunter", still_active: true, age: 55)
book1 = Book.create!(name: "The Gunslinger", has_foreword: true, pages: 100, author: author1)
book2 = Book.create!(name: "The Stand", has_foreword: false, pages: 200, author_id: author1.id)
book3 = author2.books.create!(name: "The Vagina Bible", has_foreword: true, pages: 100)
book4 = author2.books.create!(name: "The Menopause Manifesto", has_foreword: false, pages: 200)
