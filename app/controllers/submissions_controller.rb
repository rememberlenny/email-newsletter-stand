class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:edit, :update, :destroy]
  skip_authorization_check
  skip_before_action :authenticate_user!

  def new
    @submission = Submission.new
    respond_with(@submission)
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.save
    respond_with(@submission)
  end

  private
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:url, :description, :name)
    end
end
