class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  protect_from_forgery except: [:destroy]

  def new
    @post = Post.new
    @address = Prefecture.all
  end

  def index
    @posts = Post.all.page(params[:page]).per(20)
    @address = Prefecture.all
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
    @schedules = TimeSchedule.where(post_id: params[:id]).page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = t('.success')
      redirect_to request.referer
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def search
    time_range = [params[:start_time], params[:end_time]].compact.join('-')

    @posts = Post.search_with_filters(params[:keyword], params[:prefecture_id], params[:season], params[:genre],
                                      time_range)
    @posts = @posts.page(params[:page]).per(20)
    @address = Prefecture.all
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :start_time, :end_time, :budget, :image, :image_cache, :prefecture_id,
                                 :season).merge(user_id: @current_user.id)
  end
end
