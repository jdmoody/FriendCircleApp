class PostsController < ApplicationController
  before_filter :set_user, only: [:new, :create]
  def show
    @post = Post.find(params[:id])
    render 'show'
  end

  def new
    @post = @user.posts.new
    3.times do
      @post.links.build
    end
    render 'new'
  end

  def create
    @post = @user.posts.new(post_params)
    @post.links.new(link_params)
    if @post.save
      redirect_to @post, notice: ["New Post Created!"]
    else
      flash.now[:errors] = @post.errors.full_messages
      3.times do
        @post.links.build
      end
      render 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, friend_circle_ids: [])
  end

  def link_params
    params.permit(links: [:url])
          .require(:links)
          .values
          .reject { |data| data["url"].blank? }
  end

  def set_user
    @user = User.find(params[:user_id])
    @friend_circles = @user.friend_circles
  end
end
