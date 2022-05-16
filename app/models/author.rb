class Author < ApplicationRecord
  has_many :books

  validates_presence_of :name, :age
  validates :still_active, inclusion: [ true, false ]

  def self.order_by_created_time
    order(created_at: :desc)
  end

  def books_count
    books.count
  end

  def book_order(sort_order)
    books.site_order(sort_order)
  end
end
