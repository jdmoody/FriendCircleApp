class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      flash[:notice] = "You're up and running!"
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def feed
    @user = User.find(params[:id])
    @posts = @user.shared_posts.includes(:links)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
