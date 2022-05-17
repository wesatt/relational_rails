class Book < ApplicationRecord
  belongs_to :author

  validates_presence_of :name, :pages
  validates :has_foreword, inclusion: [ true, false ]

  def self.with_foreword
    where(has_foreword: true)
  end

  def self.site_order(sort_order = nil, filter_param = nil)
    if sort_order == "Alphabetical"
      Book.order(:name)
    elsif sort_order == "Filter"
      Book.where(["pages > ?", filter_param])
    else
      Book.all
    end
  end
end
