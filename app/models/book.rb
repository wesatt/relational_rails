class Book < ApplicationRecord
  belongs_to :author

  validates_presence_of :name, :pages
  validates :has_foreword, inclusion: [ true, false ]

  def self.with_foreword
    where(has_foreword: true)
  end
end
