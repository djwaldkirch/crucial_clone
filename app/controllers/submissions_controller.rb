class SubmissionsController < ApplicationController
  
  #these two are filters, which are methods that happen before, during, or after the other stuff in the action
  #
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy

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
    @submission.destroy
    flash[:success] = "Submission deleted"
    redirect_to user_path(current_user)
  end
  
  def new
    @submission = current_user.submissions.build
  end
  
  private
    
    def submission_params
        params.require(:submission).permit(:title, :artist, :genre, :lyrics)
    end
    def correct_user
      @submission = current_user.submissions.find_by(id: params[:id])
      redirect_to root_url if @submission.nil?
    end
end
