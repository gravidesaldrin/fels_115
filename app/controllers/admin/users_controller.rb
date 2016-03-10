class Admin::UsersController < AdminController
  before_action :find_user
  def destroy
    @user.destroy
    redirect_to users_path
  end
end
