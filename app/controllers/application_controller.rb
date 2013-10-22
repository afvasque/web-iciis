class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include TheRoleController, SessionHelper

  protect_from_forgery with: :exception

  def access_denied
    return render(text: 'access_denied: requires a role')
  end


end
