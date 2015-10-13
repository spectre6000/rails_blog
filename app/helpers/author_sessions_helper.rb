module AuthorSessionsHelper

  def author_log_in( author )
    session[ :author_id ] = author.id
  end

  def remember_author( author )
    author.remember_author
    cookies.permanent.signed[ :author_id ] = author.id
    cookies.permanent[ :remember_token ] = author.remember_token
  end

  def current_author
    if ( author_id = session[ :author_id ] )
      @current_author ||= Author.find_by( id: author_id )
    elsif ( author_id = cookies.signed[ :author_id ] )
      author = Author.find_by( id: author_id )
      if author && author.author_authenticated?( cookies[ :remember_token ] )
        author_log_in author
        @current_author = author
      end
    end
  end

  def author_logged_in?
    !current_author.nil?
  end

  def forget_author( author )
    author.forget_author
    cookies.delete( :author_id )
    cookies.delete( :remember_token )
  end

  def author_log_out
    forget_author( current_author )
    session.delete( :author_id )
    @current_author = nil
  end

end