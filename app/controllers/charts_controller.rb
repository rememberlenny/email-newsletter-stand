class ChartsController < ApplicationController
  def emails_sent_by_day
    render json: Email.group_by_day(:created_at).count
  end
end
