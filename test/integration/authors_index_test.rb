require 'test_helper'

class AuthorsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = authors( :authorAdmin )
    @non_admin = authors( :author1 )
  end

  test "index including pagination and delete links" do 
    log_in_as( @admin )
    get authors_path
    assert_template 'authors/index'
    assert_select 'div.pagination'
    first_page_of_authors = Author.paginate( page: 1 )
    first_page_of_authors.each do | author |
      assert_select 'a[href=?]', author_path( author ), text: author.name
      unless author == @admin
        assert_select 'a[href=?]', author_path( author ), text: "delete"
      end
    end
    assert_difference 'Author.count', -1 do 
      delete author_path( @non_admin )
    end
  end

  test "index as non-admin" do 
    log_in_as( @non_admin )
    get authors_path
    assert_select 'a', text: 'delete', count: 0
  end

end