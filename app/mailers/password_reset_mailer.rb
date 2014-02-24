class PasswordResetMailer < ActionMailer::Base
  default from: "admin@example.com"

  def password_reset_email(password_reset)
    @password_reset = password_reset
    @user = @password_reset.user

    mail(to: @user.email,
         subject: "Reset Your Password")
  end
end
