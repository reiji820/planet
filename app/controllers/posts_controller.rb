class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def new
    @post = Post.new
    @address = Prefecture.all
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @schedule = TimeSchedule.new
    @schedules = TimeSchedule.where(post_id: params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :start_time, :end_time, :budget, :image, :image_cache, :prefecture_id, :season).merge(user_id: @current_user.id)
  end
end
