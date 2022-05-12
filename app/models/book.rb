class Book < ApplicationRecord
  belongs_to :author

  validates_presence_of :name, :pages
  validates :has_foreword, inclusion: [ true, false ]
end
