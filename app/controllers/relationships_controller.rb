class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_recent_user, except: [:index]

  def index
    @user = current_user
    @users = current_user.send(params[:active]).paginate page: params[:page]
  end

  def create
    @follower = User.find params[:followed_id]
    current_user.follow @follower
    respond_to do |format|
      format.html {redirect_to @follower}
      format.js
    end
  end

  def destroy
    @followed = Relationship.find(params[:id]).followed
    current_user.unfollow @followed
    respond_to do |format|
      format.html {redirect_to @followed}
      format.js
    end
  end

  private
  def find_recent_user
    @recent_user = User.find params[:recent_user]
  end

end
