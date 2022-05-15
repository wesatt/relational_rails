class AuthorBooksController < ApplicationController
  def index
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def new
    @author = Author.find(params[:id])
  end

  def create
    author = Author.find(params[:id])
    new_book = author.books.create(book_param_param_param_pam_pa)
    new_book.save
    redirect_to "/authors/#{author.id}/books"
  end

  private
  def book_param_param_param_pam_pa
    params.permit(:name, :has_foreword, :pages)
  end
end
