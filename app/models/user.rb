# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password

  before_validation :ensure_session_token

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true

  has_many :password_resets

  has_many :friend_circles, foreign_key: :owner_id

  has_many(
    :memberships,
    class_name: "FriendCircleMembership",
    foreign_key: :member_id)

  has_many(
    :shared_friend_circles,
    through: :memberships,
    source: :friend_circle
  )

  has_many :shared_posts, through: :shared_friend_circles, source: :posts

  has_many :posts, foreign_key: :author_id

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest)
      .is_password?(unencrypted_password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(params)
    email, password = params[:email], params[:password]
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
