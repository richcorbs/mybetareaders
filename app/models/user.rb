class User < ActiveRecord::Base

  require 'digest/md5'

  serialize :reading_preferences, ActiveRecord::Coders::Hstore

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

  attr_accessor :password

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of     :email
  validates_uniqueness_of   :email

  has_many :documents
  has_many :paragraph_comments
  has_many :paragraph_ratings
  has_many :feedbacks

  def full_name
    (first_name || last_name) ? "#{first_name} #{last_name}" : email
  end

  def create_auth_token
    self.auth_token = Digest::MD5.hexdigest(self.email + (Time.now + 100.years).to_s) if self.auth_token.blank?
    self.save
  end

  def self.authenticate( email, password )
    user = User.find_by_email( email )
    if user && (user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) || password == user.auth_token)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash  = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def method_missing(id, *args, &block)
    if reading_preferences.has_key?(id.to_s)
      reading_preferences.fetch(id.to_s)
    elsif id.to_s.index('?')
      reading_preferences.fetch( ( id.to_s[0..-2] ) ) == 'true'
    else
      super
    end
  end
end
