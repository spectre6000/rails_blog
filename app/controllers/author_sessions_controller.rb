class AuthorSessionsController < ApplicationController

  def new

  end

  def create
    author = Author.find_by( email: params[ :session ][ :email ].downcase )
    if author && author.authenticate( params[ :session ][ :password ] )

    else
      flash.now[ :danger ] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy

  end

end