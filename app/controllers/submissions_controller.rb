class SubmissionsController < ApplicationController
  
  #these two are filters, which are methods that happen before, during, or after the other stuff in the action
  #this is defined in the application controller, checks to see if a user is logged in, and if not it makes them log in
  before_action :logged_in_user, only: [:new, :create, :destroy]
  #this is defined below, under private. basically checks to see if the user matches the submission/if the submission even exists. if not, redirects to root
  before_action :correct_user,   only: :destroy
  
  #when you issue a post to the new submission page it executes this action
  def create
    #stores a new submission in the @submission variable. this is done as a user.submissions.build instead of .new because it is creating something that belongs to the user
    #it takes in submission_params, which are defined below, but i believe it comes from the new submission form. a little unclear on this
    @submission = current_user.submissions.build(submission_params)
        #if the submission is valid and saves properly
        if @submission.save
            flash[:success] = "Track submitted successfully!"
            #this is the profile page of the current user.
            redirect_to user_path(current_user)
        else
            render 'new'
        end
  end
  
  #this action is executed when you issue a delete request
  def destroy
    #presumably we don't have to define what this variable is because we already get that somewhere else...but not totally sure where
    #destroy the submission
    @submission.destroy
    flash[:success] = "Submission deleted"
    #redirect to user profile
    redirect_to user_path(current_user)
  end
  
  #this gets the new view and creates an empty submission in the variable @submission
  def new
    @title = "Crucial Music | New Submission"
    @submission = current_user.submissions.build
  end
  
  private
    
    #gets the parameters from the new form, but only allows these specific parameters for the submission object
    def submission_params
        params.require(:submission).permit(:title, :artist, :genre, :lyrics)
    end
    #tries to find the submission, if it doesn't exist, redirect to root
    def correct_user
      @submission = current_user.submissions.find_by(id: params[:id])
      redirect_to root_url if @submission.nil?
    end
end
