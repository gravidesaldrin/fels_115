class StaticPagesController < ApplicationController
  layout :admin

  def home
  end

  def about
  end

  def contat_us
  end

  def help
  end

  private
  def admin
    "application"
    if logged_in? && current_user.admin?
      "admin"
    end
  end
end
