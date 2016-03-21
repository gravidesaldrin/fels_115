class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  require "will_paginate/array"

  private
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end

  def find_lesson
    @lesson = Lesson.find params[:id]
  end
end
