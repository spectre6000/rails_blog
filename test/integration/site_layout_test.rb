require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @author = authors( :author1 )
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", authors_path, count: 0
    assert_select "a[href=?]", author_path( @author.id ), count: 0
    assert_select "a[href=?]", edit_author_path( @author.id ), count: 0
    assert_select "a[href=?]", author_logout_path, count: 0
    assert_select "a[href=?]", author_login_path, count: 2
    log_in_as( @author )
    follow_redirect!
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", authors_path, count: 2
    assert_select "a[href=?]", author_path( @author.id ), count: 2
    assert_select "a[href=?]", edit_author_path( @author.id ), count: 2
    assert_select "a[href=?]", author_logout_path, count: 2
    assert_select "a[href=?]", author_login_path, count: 0
  end

end