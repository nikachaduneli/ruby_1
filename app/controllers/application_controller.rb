class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :logged_in?, :current_user
end
