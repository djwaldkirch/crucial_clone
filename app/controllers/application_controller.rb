#this is the controller that controls everything that happens on the site. if you want something to happen no matter where you are, you put it here

class ApplicationController < ActionController::Base
    #this is included by default for application controllers but essentially it protects you from certain attacks.
    protect_from_forgery with: :exception
    #there's a lot of important stuff in the sessions helper file. extends all of those methods for use here, and by extension every controller in the app
    include SessionsHelper
    
    #private means this method is only accessible internally. it's basically a helper file within the class itself. you could not call logged_in_user from elsewhere
    private
        #this method is used to redirect people to the login page if they try to access something only logged in users can do. 
        #because every other controller inherits from this one, it means the logged_in_user method can be used by any controller 
        def logged_in_user
          #this only runs if the user is NOT logged in
          #logged_in method comes from the sessions helper file, and returns a boolean
          unless logged_in?
            #this method comes from the sessions_helper file. it stores where you were trying to go, so that after you log in, it will get you there. reference comments in the helper file.
            store_location
            #adds a flash - it is not flash.now because it is redirected to the login page, so that login page counts as a new request which is what we want.
            flash[:danger] = "Please log in."
            redirect_to login_url
          end
        end
end
