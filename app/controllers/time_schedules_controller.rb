class TimeSchedulesController < ApplicationController
  protect_from_forgery except: [:destroy]

  def new; end

  def create
    @schedule = TimeSchedule.new(plan_params)
    @post = Post.find(params[:post_id])
    if @schedule.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'posts/show' }
      end
    end
  end

  def destroy
    @schedule = TimeSchedule.find(params[:id])
    @post = Post.find(params[:post_id])
    return unless @schedule.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  def update
    @schedule = TimeSchedule.find(params[:id])
    @post = Post.find(params[:post_id])

    if @schedule.update(plan_params)
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'posts/show' }
      end
    end
  end

  private

  def plan_params
    params.require(:time_schedule).permit(:time_stamp, :plan).merge(post_id: params[:post_id])
  end
end
