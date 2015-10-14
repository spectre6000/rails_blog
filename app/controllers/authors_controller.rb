class AuthorsController < ApplicationController

  before_action :logged_in_author,  only: [ :edit, :update ]
  before_action :correct_author,    only: [ :edit, :update ]

  def index 
    @authors = Author.all
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

  def edit
    @author = Author.find( params[ :id ] )
  end

  def update
    @author = Author.find( params[ :id ] )
    if @author.update_attributes( author_params )
      flash[ :success ] = "Profile updated"
      redirect_to @author
    else
      render 'edit'
    end
  end

  private

    def author_params
      params.require(:author).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in author.
    def logged_in_author
      unless author_logged_in?
        store_location
        flash[ :danger ] = "Please log in."
        redirect_to author_login_url
      end
    end

    # Confirms the correct author.
    def correct_author
      @author = Author.find( params[ :id ] )
      redirect_to( root_url ) unless current_author?( @author )
    end

end