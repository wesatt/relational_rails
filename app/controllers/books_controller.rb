class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    update_book = Book.find(params[:id])
    update_book.update(book_param_param_param_pam_pa)
    update_book.save
    redirect_to "/books/#{params[:id]}"
  end

  private
  def book_param_param_param_pam_pa
    params.permit(:name, :has_foreword, :pages)
  end
end
