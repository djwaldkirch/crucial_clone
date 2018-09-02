class UsersController < ApplicationController
    #defined in application controller, allows these actions only if you are logged in
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    #this is potentially confusing! the submissions controller has its own correct_user method defined under private (below).
    #that one made sure that the submission exists, otherwise it redirected you to the root.
    #this one makes sure that the user being worked with is the same one that is actually logged in, or else it redirects to root
    #see more comments in private section
    before_action :correct_user,   only: [:edit, :update]
    #this checks if a user is an admin - only admins can destroy a user
    before_action :admin_user,     only: :destroy
    
    #this is for the user profile page. it gets two variables that are needed on the view page
    #the first variable is the user that will be shown along with any other info about him/her, but in our case it is just the name and email
    def show
        @title = "Crucial Music | Profile"
        #gets the user by id#
        @user = User.find(params[:id])
        #this gets all submissions by that user, but sets them up to paginate. this part is tricky and i don't totally get it
        @submissions = @user.submissions.paginate(page: params[:page])
    end
    
    #this gets the 'new' view and creates a blank user for use in the form
    def new
        @title = "Crucial Music | New User"
        @user = User.new
    end
    
    #this shows all users and paginates them. for use in the index view.
    def index
        @title = "Crucial Music | Users Index"
        @users = User.paginate(page: params[:page])
    end
    
    #this creates a new user based on user_params, which comes from the form (and is also defined under private below)
    def create
        @user = User.new(user_params)
        #if the user successfully saves, log them in and redirect them to their profile page
        if @user.save
            #the log_in method comes from the sessions helper
            #@user is technically an argument here but we don't put it in parentheses...just cause
            log_in @user
            flash[:success] = "Welcome to Crucial Music!"
            #i'm honestly sure why @user actually works as a path here.
            redirect_to @user
        else
            #just renders the signup page again if something is wrong.
            render 'new'
        end
    end
    
    #just gets the @user variable for use in editing the user.
    #this action is just getting the user edit view, not actually making the change
    def edit
      @title = "Crucial Music | Edit User"
      @user = User.find(params[:id]) 
    end
    
    
    #this is the action that actually makes the change, it executes when a PATH request is made on the edit view
    def update
        #find the user and store it
        @user = User.find(params[:id])
        #update_attributes is a special ruby method, i think. this checks to see if the user_params have changed. if they have, gives a flash message and redirects to profile page
        if @user.update_attributes(user_params)
            flash[:success] = "Welcome to Crucial Music!"
            redirect_to @user
        else
            #otherwise just renders the edit page again
            render 'edit'
        end
    end
    
    #you can only do this as an admin, and it is executed by a button. very simple - just finds the user and deletes it from the database.
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User deleted"
        redirect_to users_url
    end
    
    private
        #only allows certain params to be passed into the form. if we put something else in the form it would cause an error because of this.
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
    
    #i'm actually not sure this is necessary, since it is already defined in the application controller. could this be an oversight by the rails tutorial??
    #anyway, see the comments in the application controller for this one.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    #as stated at the very top of this controller, this one works differently from the correct_user in the submissons controller
    #this finds the user and stores it as an object
    #it makes sure that the user we are working with is the one who is currently logged in.
    #current_user comes from the sessions_helper file
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    #this is just a check to see if the user is an admin. if they try to do something admin-y when they aren't one, it will redirect them to the root.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
