class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_identity!
  ##This locks the whole app will add to specific pages
end
