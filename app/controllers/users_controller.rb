class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
    @favorited_posts = @user.favorited_posts.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :place_of_birth, :hobbies,
                                 :self_introduction, :salt, :avatar, :avatar_cache)
  end
end
