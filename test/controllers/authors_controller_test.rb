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

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Author.count' do
      delete :destroy, id: @author
    end
    assert_redirected_to author_login_url
  end

  test "should redirect destroy when logged in as non-admin" do 
    log_in_as( @other_author )
    assert_no_difference 'Author.count' do 
      delete :destroy, id: @author
    end
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do 
    log_in_as( @author )
    assert_not @author.admin?
    patch :update, id: @author, author: { password: 'password', 
                                          password_confirmation: 'password',
                                          admin: true }
    assert_not @author.reload.admin?
  end

end
