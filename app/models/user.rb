class User < ActiveRecord::Base
  #setters/getters
  attr_reader :password, :password2

  #validations
  validates :email, :session_token, :password_digest,  presence: true
  validates :password, length: {minimum: 8, allow_nil: true}
  validate :confirmed_password, on: :create

  after_initialize :ensure_session_token

  def confirmed_password
    unless @password == @password2
      errors.add(:password, "doesn't match confirmation password")
    end
  end

  #associations
  has_many :notes

  #class methods
  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  #instance methods
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password2=(password2)
    @password2 = password2
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

end
