class SessionsController < ApplicationController
  
  #this is the new action for sessions, but since we don't really have a "page" needed to create a new session, it doesn't really do anything, logging in skips right to create
  def new
  end
  
  
  def create
    #this finds a user from the database by e-mail. i'm not exactly sure how the [:session] part of this works
    user = User.find_by(email: params[:session][:email].downcase)
    #if it finds a user, and the password matches...
    if user && user.authenticate(params[:session][:password])
      # it logs in the user
      log_in user
      #this method comes from sessions_helper. it redirects you to the page you were trying to go, or a default, in this case the user profile page
      redirect_back_or user
    else
      #creates a flash notice, it has to be flash.now because we are not issuing a new request when we render new
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  #this is called when we click log out
  def destroy
    #logs out user
    log_out
    #takes us back to the home page
    redirect_to root_url
  end
end
