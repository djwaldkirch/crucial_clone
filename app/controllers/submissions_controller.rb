class SubmissionsController < ApplicationController
    
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def create
    @submission = current_user.submissions.build(submission_params)
        if @submission.save
            flash[:success] = "Track submitted successfully!"
            redirect_to user_path(current_user)
        else
            render 'new'
        end
  end

  def destroy
  end
  
  def new
    @submission = current_user.submissions.build
  end
  
  private
    
        def submission_params
            params.require(:submission).permit(:title, :artist, :genre, :lyrics)
        end
end
