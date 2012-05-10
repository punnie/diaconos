module ApplicationHelper
  def signed_in?
    not session[:current_user].blank?
  end

  def current_user
    User.find(session[:current_user])
  end

  def authenticate
    redirect_to login_url if session[:current_user].blank?
  end
end
