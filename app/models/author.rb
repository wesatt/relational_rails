class Author < ApplicationRecord
  has_many :books

  validates_presence_of :name, :age
  validates :still_active, inclusion: [ true, false ]
end
