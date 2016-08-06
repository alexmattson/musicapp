class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login!(user)
    session[:session_token] = user.session_token
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def logout
    current_user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def valid_view?
    unless logged_in?
      redirect_to new_session_url
    end
  end

  helper_method :current_user, :logged_in?
end
