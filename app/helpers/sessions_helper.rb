module SessionsHelper
  # Used when signing in. Cookies are used if you want to be remembered at login
  def sign_in(user, remember)
    auth_token = user.auth_token
    if remember
      cookies.permanent[:auth_token] = auth_token
    else
      cookies[:auth_token] = auth_token
    end
    self.current_user = user
  end

  def sign_out
    cookies.delete(:auth_token)
    self.current_user = nil
  end

  # Check to make sure you are a valid login to the session
  def signed_in?
    !current_user.nil?
  end

  # stores user name as current user for validation checks
  def current_user=(user)
    @current_user = user
  end
  def current_user
    @current_user ||= User.find_by_auth_token cookies[:auth_token] if cookies[:auth_token]
  end

  def current_user?(user)
    user == current_user
  end

  #Redirects webpage if error has occured
  def redirect_back_or(default)
    redirect_to(cookies[:return_to] || default)
    cookies.delete(:return_to)
  end
  def store_location
    cookies[:return_to] = request.url if request.get?
  end
end
