ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test author is logged in.
  def author_is_logged_in?
    !session[ :author_id ].nil?
  end

  # Logs in a test author.
  def log_in_as( author, options = {} )
    password =    options[ :password ]    || 'password'
    remember_me = options[ :remember_me ] || '1'
    if integration_test?
      post author_login_path, session: { email: author.email, 
                                        password: password, 
                                        remember_me: remember_me }
    else
      session[ :author_id ] = author.id 
    end
  end

  private

    # Returns true inside an integration test.
    def integration_test?
      defined?( post_via_redirect )
    end

end