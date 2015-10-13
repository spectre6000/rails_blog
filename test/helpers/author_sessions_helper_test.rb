require 'test_helper'

class AuthorSessionsHelperTest < ActionView::TestCase

  def setup
    @author = authors( :author1 )
    remember_author( @author )
  end

  test "current_author returns right author when author_session is nil" do 
    assert_equal @author, current_author
    assert author_is_logged_in?
  end

  test "current_author returns nil when remember digest is wrong" do 
    @author.update_attribute( :remember_digest, Author.digest( Author.new_token ) )
    assert_nil current_author
  end

end