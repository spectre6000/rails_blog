class Author < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  validates :name,      presence: true, 
                        length: { maximum: 50 }
  validates :email,     presence: true, 
                        length: { maximum: 255 }, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  validates :password,  presence: true,
                        length: { minimum: 6 },
                        allow_nil: true

  def self.digest( string )
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create( string, cost: cost )
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember_author
    self.remember_token = Author.new_token
    update_attribute( :remember_digest, Author.digest( remember_token ) )
  end

  def author_authenticated?( remember_token )
    return false if remember_digest.nil?
    BCrypt::Password.new( remember_digest ).is_password?( remember_token )
  end

  def forget_author
    update_attribute( :remember_digest, nil )
  end
  
end