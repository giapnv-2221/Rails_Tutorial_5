class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :admin_user, only: %i(destroy)
  before_action :correct_user, except: %i(index new create)

  def index
    @users = User.get_list.latest
      .page(params[:page]).per Settings.users.paging.num_per_page
  end

  def show
    @microposts = @user.microposts.recent
      .page(params[:page]).per Settings.microposts.paging.num_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = I18n.t "users.alert.activate"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.edit.success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:danger] = t "users.alert.deleted"
    else
      flash[:danger] = t "users.alert.error"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user)
      .permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user == current_user || current_user.admin?
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
