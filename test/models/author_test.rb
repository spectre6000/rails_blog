require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  
  def setup
    @author = Author.new( name: "example author", 
                          email: "author@example.com",
                          admin: false,
                          password: "p455w0rd",
                          password_confirmation: "p455w0rd" )
  end

  test "author should be valid" do 
    assert @author.valid?
  end

  test "name should be present" do
    @author.name = ''
    assert_not @author.valid?
  end

  test "name should not be too long" do 
    @author.name = "na" * 22 + "batman!"
    assert_not @author.valid?
  end

  test "email should be present" do
    @author.email = ''
    assert_not @author.valid?
  end

  test "email should not be too long" do 
    @author.email = "na" * 125 + "batman!"
    assert_not @author.valid?
  end

  test "email should accept valid formats" do 
    valid_emails = [  "author@example.com",
                      "AUTHOR@example.com", 
                      "AN_AUTH-or@example.test.gov",
                      "example.author@example.cn",
                      "example+author@test.de" ]
    valid_emails.each do | address |
      @author.email = address
      assert @author.valid?, "#{ address.inspect } should be valid"
    end
  end

  test "email should not accept valid formats" do 
    invalid_emails = [  "author@example,com",
                        "author@example..com",
                        "AUTHOR_at_example.com", 
                        "AN_AUTH-or@example",
                        "example@author_example.cn",
                        "example@author+test.de" ]
    invalid_emails.each do | address |
      @author.email = address
      assert_not @author.valid?, "#{ address.inspect } should be invalid"
    end
  end

  test "email addresses should be unique" do 
    duplicate_author = @author.dup
    duplicate_author.email = @author.email.downcase
    @author.save
    assert_not duplicate_author.valid?
  end

  test "password should be non-blank" do 
    @author.password = @author.password_confirmation = ''
    assert_not @author.valid?
  end

  test "password should be at least 6 characters" do 
    @author.password = @author.password_confirmation = "bruce"
    assert_not @author.valid?
  end

  test "author_authenticated? should return false for an author with nil digest" do 
    assert_not @author.author_authenticated?( '' )
  end

end