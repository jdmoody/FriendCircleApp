class PasswordResetsController < ApplicationController
  before_action :set_reset_and_user, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    PasswordReset.send_instructions(@user) if @user
    flash[:notice] = "Instructions delivered, maybe ;)"
    redirect_to root_url
  end

  def edit
  end

  def update
    if @password_reset.created_at < 2.hours.ago
      redirect_to new_password_reset_path
      flash[:alert] = "Password reset has expired."
    elsif @user.update_attributes(password: user_params)
      flash[:success] = "Updated!"
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def reset_params
    params[:reset_token]
  end

  def user_params
    params[:user][:password]
  end

  def set_reset_and_user
    @password_reset = PasswordReset.find_by(reset_token: reset_params)
    redirect_to new_session_url unless @password_reset
    @user = @password_reset.user
  end
end
