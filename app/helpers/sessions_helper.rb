module SessionsHelper
  #these are a bunch of methods that will be used by the sessions controller AND other controllers.
  #normally they could be used by sessions only, but since the Application controller includes this file, these can be used EVERYWHERE. dang.
  
  
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #this takes user as an argument, normally @user will be passed in here which is kind of confusion
  #it returns a boolean as to 
  def current_user?(user)
    user == current_user
  end
  
  
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
