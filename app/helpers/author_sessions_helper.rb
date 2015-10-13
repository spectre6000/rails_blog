module AuthorSessionsHelper

  def author_log_in( author )
    session[ :author_id ] = author.id
  end

  def current_author
    @current_author ||= Author.find_by( id: session[ :author_id ] )
  end

  def author_logged_in?
    !current_author.nil?
  end

  def author_log_out
    session.delete( :author_id )
    @current_author = nil
  end

end