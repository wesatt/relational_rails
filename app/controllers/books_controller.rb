class BooksController < ApplicationController
  def index
    @books = Book.with_foreword
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to "/books/#{params[:id]}"
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to "/books"
  end

  private
    def book_params
      params.permit(:name, :has_foreword, :pages)
    end
end
