class NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]

  def index
    @newsletters = Newsletter.all
    respond_with(@newsletters)
  end

  def show
    respond_with(@newsletter)
  end

  def new
    @newsletter = Newsletter.new
    respond_with(@newsletter)
  end

  def edit
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    @newsletter.save
    respond_with(@newsletter)
  end

  def update
    @newsletter.update(newsletter_params)
    respond_with(@newsletter)
  end

  def destroy
    @newsletter.destroy
    respond_with(@newsletter)
  end

  private
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    def newsletter_params
      params.require(:newsletter).permit(:name, :url, :description)
    end
end
