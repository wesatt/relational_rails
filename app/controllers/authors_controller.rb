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
    new_author = Author.create(author_param_param_param_pam_pa)
    new_author.save
    redirect_to "/authors"
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    update_author = Author.find(params[:id])
    update_author.update(author_param_param_param_pam_pa)
    update_author.save
    redirect_to "/authors/#{params[:id]}"
  end

  private
  def author_param_param_param_pam_pa
    params.permit(:name, :still_active, :age)
  end
end
