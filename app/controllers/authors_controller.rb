class AuthorsController < ApplicationController

  def show
    @author = Author.find( params[ :id ] )
  end

  def new
    @author = Author.new
  end

end