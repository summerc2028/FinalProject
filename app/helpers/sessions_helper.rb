module SessionsHelper

  def sign_in(user)
    auth_token = User.new_auth_token
    cookies.permanent[:auth_token] = auth_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    auth_token = cookies[:auth_token]
    @current_user ||= User.find_by_auth_token auth_token
  end
end
