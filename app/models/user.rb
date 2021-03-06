require 'open-uri'

class User < ApplicationRecord
  # after_initialize :ensure_default_image

  attr_reader :password

  has_one_attached :user_image

  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :posts, foreign_key: :user_id
  has_many :likes, foreign_key: :user_id
  has_many :notifications, foreign_key: :recipient_id

  has_many :follows, class_name: :Follow
  has_many :followings, through: :follows, source: :follow

  has_many :received_followings, class_name: :Follow, foreign_key: :follow_id
  has_many :followers, through: :received_followings, source: :user

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    generate_unique_session_token
    save!
    self.session_token
  end

  # private

  def ensure_session_token
    generate_unique_session_token unless self.session_token
  end

  def new_session_token
    SecureRandom.urlsafe_base64
  end

  def generate_unique_session_token
    self.session_token = new_session_token
    while User.find_by(session_token: self.session_token)
      self.session_token = new_session_token
    end
    self.session_token
  end

  def ensure_default_image
      unless self.user_image.attached?
          file = open("https://thepowerofthedream.org/wp-content/uploads/2015/09/generic-profile-picture.jpg")
          self.user_image.attach(io: file, filename: 'generic-profile-picture.jpg')
      end
  end
end
