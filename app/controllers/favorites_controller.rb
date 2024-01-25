class FavoritesController < ApplicationController
  before_action :set_post
  def create
    @like = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @like.save
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @like = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
