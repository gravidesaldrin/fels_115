class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :require_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.normal.paginate page: params[:page]
  end

  def show
    if params[:tab].nil? or params[:tab] == "activities"
      activities = @user.activities
      if @user == current_user
        activities += current_user.following_activities
      end
      @activities = activities.paginate page: params[:page]
    else
      @users = @user.send(params[:tab]).paginate page: params[:page]
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.activate
      log_in @user
      flash[:success] = t ".info"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def require_user
    if current_user.admin?
      flash[:warning] = t ".warning"
      redirect_to admin_user_path current_user
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find params[:id]
  end
end
