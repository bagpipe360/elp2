class HomeController < ApplicationController

  def home
    if session[:user_id].blank?
      @logged_in = false
    else
      @logged_in = true
      user = User.find(session[:user_id])
      user.online = true
      user.save
    end
  end
end
