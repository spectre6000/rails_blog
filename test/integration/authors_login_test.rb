require 'test_helper'

class AuthorsLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @author = authors( :author1 )
  end

  test "author login with invalid information" do 
    get author_login_path
    assert_template 'author_sessions/new'
    post author_login_path, session: { email: "", password: "" }
    assert_template 'author_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "author login with valid information followed by logout" do 
    get author_login_path
    post author_login_path, session: { email: @author.email, password: 'password' }
    assert author_is_logged_in?
    assert_redirected_to @author
    follow_redirect!
    assert_template 'authors/show'
    assert_select "a[href=?]", author_login_path, count: 0
    assert_select "a[href=?]", author_logout_path
    assert_select "a[href=?]", author_path( @author )
    delete author_logout_path
    assert_not author_is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", author_login_path
    assert_select "a[href=?]", author_logout_path, count: 0
    assert_select "a[href=?]", author_path( @author ), count: 0
  end

end