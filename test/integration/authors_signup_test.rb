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

end
