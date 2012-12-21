class User < ActiveRecord::Base

  require 'digest/md5'

  serialize :reading_preferences, ActiveRecord::Coders::Hstore

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :credit_cents, :stripe_token, :coupon
  attr_accessor :password, :stripe_token, :coupon

  before_save :encrypt_password
  before_save :update_stripe

  validates_confirmation_of :password
  validates_presence_of     :email
  validates_uniqueness_of   :email

  has_many :charges
  has_many :documents
  has_many :feedbacks
  has_many :paragraph_comments
  has_many :paragraph_ratings
  has_many :volunteers

  def self.authenticate( email, password )
    user = User.find_by_email( email )
    if user && (user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) || password == user.auth_token)
      user
    else
      nil
    end
  end

  def create_auth_token
    self.auth_token = Digest::MD5.hexdigest(self.email + (Time.now + 100.years).to_s) if self.auth_token.blank?
    self.save
  end

  def document_ids
    documents.collect(&:id)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash  = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def full_name
    (first_name || last_name) ? "#{first_name} #{last_name}" : email
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

  def update_stripe
    return if email.include?('@example.com') and not Rails.env.production?
    if stripe_customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => email,
          :description => (full_name || "No name"),
          :card => stripe_token
        )
      else
        customer = Stripe::Customer.create(
          :email => email,
          :description => name,
          :card => stripe_token,
        )
      end
    else
      customer = Stripe::Customer.retrieve(stripe_customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = (full_name || 'No name')
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.stripe_customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end

end
