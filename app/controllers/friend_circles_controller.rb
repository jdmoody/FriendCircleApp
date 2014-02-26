class FriendCirclesController < ApplicationController
  before_action :set_users, except: [:index]
  before_action :set_user, only: [:create, :new]
  before_action :set_friend_circle, only: [:edit, :update, :show]
  before_action :set_owner, only: [:edit, :update]

  def index
    render 'index'
  end

  def show
    render 'show'
  end

  def new
    @friend_circle = @user.friend_circles.new()
    render 'new'
  end

  def create
    @friend_circle = @user.friend_circles.new(friend_circle_params)

    if @friend_circle.save
      redirect_to @friend_circle, notice: "New Friend Circle Created!"
    else
      flash[:errors] = @friend_circle.errors.full_messages
      render 'new'
    end
  end

  def edit
    'edit'
  end

  def update
    if @friend_circle.update_attributes(friend_circle_params)
      redirect_to @friend_circle, notice: "Friend Circle Updated!"
    else
      flash[:errors] = @friend_circle.errors.full_messages
      render 'edit'
    end
  end

  private
  def friend_circle_params
    params.require(:friend_circle).permit(:name, member_ids: [])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_friend_circle
    @friend_circle = FriendCircle.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def set_owner
    @user = @friend_circle.owner
  end
end
