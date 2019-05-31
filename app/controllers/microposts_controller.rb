class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user , only: %i(destroy)

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t "users.alert.success"
      redirect_to root_path
    else
      @feed_items =[]
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:warning] = t "microposts.destroy_post"
      redirect_to request.referer || root_path
    else
      flash[:danger] = t "microposts.error"
      redirect_to root_path
    end
  end

  private
  def micropost_params
    params.require(:micropost).permit :content
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_path unless @micropost
  end
end
