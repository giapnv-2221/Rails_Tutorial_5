class UsersController < ApplicationController
  def index
    @users = User.select("id, name, email").order("created_at desc")
      .page(params[:page]).per Settings.users.paging.num_per_page
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to new_user_path unless @user.present?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = I18n.t "users.alert.success"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
      .permit :name, :email, :password, :password_confirmation
  end
end
