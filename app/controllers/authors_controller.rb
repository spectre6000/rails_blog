class AuthorsController < ApplicationController

  def index 

  end
  
  def show
    @author = Author.find( params[ :id ] )
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new( author_params )
    if @author.save
      author_log_in @author
      flash[ :success ] = "Welcome to " + Rails.application.config.blog_title + "!"
      redirect_to @author
    else
      render 'new'
    end
  end

  private

    def author_params
      params.require(:author).permit(:name, :email, :password, :password_confirmation)
    end

end