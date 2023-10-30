class PostsController < ApplicationController
  def new
    @post = Post.new
    @address = Prefecture.all
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :start_time, :end_time, :budget, :image, :prefecture_id, :season)
  end
end
