class NewslettersController < ApplicationController
  respond_to :html, :json
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]
  before_action :set_emails, only: [:show]
  load_and_authorize_resource only: [:edit, :update, :destroy]
  skip_authorization_check only: [:show, :index]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    if params[:tag]
      @newsletters = Newsletter.tagged_with(params[:tag])
    else
      @newsletters = Newsletter.all
    end
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
      @newsletter = Newsletter.friendly.find(params[:id])
    end

    def set_emails
      @emails = Email.where(newsletter_id: @newsletter.id)
    end

    def newsletter_params
      params.require(:newsletter).permit(:name, :url, :description, :featured_image, :tag_list)
    end
end
