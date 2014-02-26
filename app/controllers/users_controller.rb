class UsersController < ApplicationController
  def new
    @user = User.new
    @post = @user.posts.new
    3.times do
      @post.links.build
    end
    render :new
  end

  def create
    @user = User.new(user_params)
    @post = @user.posts.new(post_params)
    @post.links.new(link_params)

    if @user.save
      login(@user)
      flash[:notice] = ["Welcome!"]
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def feed
    @user = User.find(params[:id])
    @posts = @user.shared_posts.includes(:links)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
  def post_params
    params.require(:post).permit(:title, :body, friend_circle_ids: [])
  end

  def link_params
    params.permit(links: [:url])
          .require(:links)
          .values
          .reject { |data| data["url"].blank? }
  end
end
