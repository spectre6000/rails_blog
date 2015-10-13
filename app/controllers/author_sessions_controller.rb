class AuthorSessionsController < ApplicationController

  def new

  end

  def create
    author = Author.find_by( email: params[ :session ][ :email ].downcase )
    if author && author.authenticate( params[ :session ][ :password ] )
      author_log_in author
      params[ :session ][ :remember_me ] == '1' ? remember_author( author ) : forget_author( author )
      redirect_to author
    else
      flash.now[ :danger ] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    author_log_out if author_logged_in?
    redirect_to root_url
  end

end