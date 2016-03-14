class Admin::UsersController < AdminController
  before_action :find_user, except: [:index]

  def index
    @users = User.order(:name).paginate page: params[:page]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      if current_user == @user
        redirect_back_or admin_user_path @user
      else
        redirect_back_or admin_users_path
      end
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit:name, :email, :password,
      :password_confirmation
  end
end
