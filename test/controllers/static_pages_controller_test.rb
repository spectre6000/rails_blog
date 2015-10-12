require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  def setup
    @page_title = "#{Rails.application.config.blog_title}"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@page_title}"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@page_title}"
  end

end
