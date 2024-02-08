class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  protect_from_forgery except: [:destroy]

  def new
    @post = Post.new
    @post.time_schedules.build
    @address = Prefecture.all
  end

  def index
    @posts = Post.all.page(params[:page]).per(20)
    @recommended_posts = recommend_posts 
    @address = Prefecture.all
    @user_favorite_post_ids = current_user ? current_user.favorites.pluck(:post_id) : []
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
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
    @user_favorite_post_ids = current_user ? current_user.favorites.pluck(:post_id) : []
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :start_time, :end_time, :budget, :image, :image_cache, :prefecture_id,
                                 :season, time_schedules_attributes: %i[id time_stamp genre address latitude longitude plan _destroy]).merge(user_id: @current_user.id)
  end

  def recommend_posts
    user = User.find(current_user.id)
  
    # 居住地に基づいて投稿を絞り込む
    prefecture_id = Prefecture.find_by(name: user.residence)&.id
    recommended_posts = Post.by_prefecture(prefecture_id) if prefecture_id.present?
  
    # いいねした投稿のジャンルに基づいてさらに絞り込む
    if recommended_posts.present?
      liked_posts_genres = Favorite.joins(post: :time_schedules).where(user_id: user.id).pluck('time_schedules.genre').uniq
      recommended_post_ids = TimeSchedule.where(genre: liked_posts_genres).pluck(:post_id).uniq
      recommended_posts = recommended_posts.where(id: recommended_post_ids)
    end
  
    recommended_posts || Post.none
  end
  
end
