class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login(@user)
      flash[:success] = ["You signed in!"]
      redirect_to @user
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end