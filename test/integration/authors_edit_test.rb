require 'test_helper'

class AuthorsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @author = authors( :author1 )
  end

  test "unsuccessful edit" do
    log_in_as( @author )
    get edit_author_path( @author )
    assert_template 'authors/edit'
    patch author_path( @author ), author: { name: '',
                                            email: 'email@invalid',
                                            password: 'pass',
                                            password_confirmation: 'word' }
    assert_template 'authors/edit'
  end

  test "successful edit with friendly forwarding" do 
    get edit_author_path( @author )
    assert_equal session[ :forwarding_url ], edit_author_url( @author )
    log_in_as( @author )
    assert_redirected_to edit_author_path( @author )
    assert_equal session[ :forwarding_url ], nil
    log_in_as( @author )
    assert_redirected_to author_path( @author )
    name = "Test Author"
    email = "test@author.com"
    patch author_path( @author ), author: { name: name,
                                            email: email, 
                                            password: '',
                                            password_confirmation: '' }
    assert_not flash.empty?
    assert_redirected_to @author
    @author.reload
    assert_equal name, @author.name
    assert_equal email, @author.email 
  end

end