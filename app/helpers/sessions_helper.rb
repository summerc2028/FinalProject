module SessionsHelper

  def sign_in(user, remember)
    auth_token = User.new_auth_token
    if remember
      cookies.permanent[:auth_token] = auth_token
    else
      cookies[:auth_token] = auth_token
    end
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_auth_token cookies[:auth_token] if cookies[:auth_token]
  end
end
