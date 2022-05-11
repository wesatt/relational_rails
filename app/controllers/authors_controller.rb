class AuthorsController < ApplicationController
  def index
    @authors = ["author1", "author2", "author3"]
  end
end
