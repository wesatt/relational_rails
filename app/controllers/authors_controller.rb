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
    new_author = Author.create(param_param_param_pam_pa)
    new_author.save
    redirect_to "/authors"
  end

  private
  def param_param_param_pam_pa
    params.permit(:name, :still_active, :age)
  end
end
