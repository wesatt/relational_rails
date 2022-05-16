class AuthorsController < ApplicationController
  def index
    @authors = Author.order_by_created_time
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
  end

  def create
    Author.create(author_params)
    redirect_to "/authors"
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    author = Author.find(params[:id])
    author.update(author_params)
    redirect_to "/authors/#{params[:id]}"
  end

  def destroy
    author = Author.find(params[:id])
    author.books.destroy_all
    author.destroy
    redirect_to "/authors"
  end

  private
    def author_params
      params.permit(:name, :still_active, :age)
    end
end
