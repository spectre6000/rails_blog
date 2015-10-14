require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase

  def setup
    @author = authors( :author1 )
    @other_author = authors( :author2 )
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do 
    get :edit, id: @author
    assert_not flash.empty?
    assert_redirected_to author_login_url
  end

  test "should redirect update when not logged in" do 
    patch :update, id: @author, author: { name: @author.name,
                                          email: @author.email }
    assert_not flash.empty?
    assert_redirected_to author_login_url
  end

  test "should redirect edit when logged in as wrong user" do 
    log_in_as( @other_author )
    get :edit, id: @author
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do 
    log_in_as( @other_author )
    patch :update, id: @author, author: { name: @author.name, 
                                          email: @author.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
