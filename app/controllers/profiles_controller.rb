class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t('.success')
      redirect_to edit_profile_path
    else
      render :edit
    end
  end

  def user_posts
    @user_posts = current_user.posts.order('created_at DESC').page(params[:page]).per(10)
  end

  def favorited_posts
    @favorited_posts = current_user.favorited_posts.page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :residence, :hobbies, :self_introduction, :avatar, :avatar_cache)
  end
end
