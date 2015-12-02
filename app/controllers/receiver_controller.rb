class ReceiverController < ApplicationController
  respond_to :html, :json
  skip_authorization_check
  skip_before_action :authenticate_user!
  def email_processor
    EmailsWorker.perform_async(email)
  end
end
