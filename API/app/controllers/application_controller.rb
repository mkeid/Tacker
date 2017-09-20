class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :json
  #protect_from_forgery with: :null_session
  serialization_scope :current_user

protected
  def current_user
    if session[:user]
      @current_user = User.find(session[:user][:id])
    end
  end
  helper_method :current_user

end
