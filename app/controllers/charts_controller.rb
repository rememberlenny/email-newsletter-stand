class ChartsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def emails_sent_by_day
    render json: Email.group_by_hour(:created_at).count
  end
end
