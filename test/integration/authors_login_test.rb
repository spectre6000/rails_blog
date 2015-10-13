require 'test_helper'

class AuthorsLoginTest < ActionDispatch::IntegrationTest
  
  test "log in with invalid information" do 
    get author_login_path
    assert_template 'author_sessions/new'
    post author_login_path, session: { email: "", password: "" }
    assert_template 'author_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end