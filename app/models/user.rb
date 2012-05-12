class User < ActiveRecord::Base
  class << self
    def encrypt(password, salt)
      Digest::SHA1.hexdigest("#{salt}#{password}MACACADA");
    end

    def authenticate!(user_params)
      user = User.find_by_username(user_params[:username])
      return nil if user.nil?
      return user if user.password_encrypted.eql?(User.encrypt(user_params[:password_attempt], user.password_salt))
    end
  end

  attr_accessor :password
  attr_accessible :username, :email, :email_confirmation, :password

  has_many :votes, dependent: :destroy

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  validates :email, confirmation: true, on: :create
  validates :email_confirmation, presence: true, on: :create
  validates :password, presence: true, on: :create

  def password
    @password
  end

  def password=(password)
    @password = password
    return if @password.blank?

    self.password_salt = Digest::SHA1.hexdigest("#{Time.now}#{self.username}")
    self.password_encrypted = User.encrypt(@password, self.password_salt)
  end
end
