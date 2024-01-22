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

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :place_of_birth, :hobbies, :self_introduction, :avatar, :avatar_cache)
  end
end
