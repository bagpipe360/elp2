class HomeController < ApplicationController
  def home
    case
    when current_identity.user.nil?
      redirect_to '/users/new'
    else
    #  current_identity.user.online = true
   #   current_identity.user.save
      redirect_to '/home'
    end
  end


end
