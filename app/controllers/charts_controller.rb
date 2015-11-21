class ChartsController < ApplicationController
  def emails_sent
    render json: Task.group_by_day(:completed_at).count
  end
end
