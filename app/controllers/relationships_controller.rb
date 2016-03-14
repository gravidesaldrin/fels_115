class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @users = current_user.send(params[:active]).paginate page: params[:page]
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    @users = current_user.following.paginate page: params[:page]
    @following = @users
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
