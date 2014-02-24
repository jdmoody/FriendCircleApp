# == Schema Information
#
# Table name: password_resets
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  reset_token :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class PasswordReset < ActiveRecord::Base
  before_validation :set_reset_token

  validates :user_id, presence: true
  validates :reset_token, presence: true, uniqueness: true

  belongs_to :user

  def self.send_instructions(user)
    password_reset = user.password_resets.create!
    msg = PasswordResetMailer.password_reset_email(password_reset)
    msg.deliver!
  end

  private
  def set_reset_token
    self.reset_token = User.generate_session_token
  end
end