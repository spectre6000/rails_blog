require 'test_helper'

class AuthorsSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get new_author_path
    assert_no_difference 'Author.count' do
      post authors_path, author: {  name: '',
                                    email: 'author@invalid',
                                    password: 'foo',
                                    password_confirmation: 'bar' }
    end
    assert_template 'authors/new'
  end

  test "valid signup information" do
    get new_author_path
    assert_difference 'Author.count', 1 do
      post_via_redirect authors_path, author: { name: 'test_author',
                                                email: 'author@valid.com',
                                                password: 'password',
                                                password_confirmation: 'password' }
    end
    assert_template 'authors/show'
    assert author_is_logged_in?
  end

end
