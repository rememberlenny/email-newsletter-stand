class NewslettersController < ApplicationController
  respond_to :html, :json
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]
  before_action :set_emails, only: [:show]
  load_and_authorize_resource only: [:edit, :update, :destroy]
  skip_authorization_check only: [:show, :index, :unconfirmed]
  skip_before_action :authenticate_user!, only: [:show, :index, :unconfirmed]

  def unconfirmed
    @newsletters = []
    Newsletter.all.each do |newsletter|
      if Email.where(newsletter_id: newsletter.id).count < 2
        @newsletters << newsletter
      end
    end
  end

  def index
    if params[:tag]
      @newsletters = Newsletter.tagged_with(params[:tag]).page params[:page]
    else
      @newsletters = Newsletter.all.where.not(admin_email: true).order('updated_at DESC').page params[:page]
    end
    respond_with(@newsletters)
  end

  def show
    @set_title = @newsletter.name
    @set_meta_description = @newsletter.description
    @set_meta_keyword = @newsletter.tag_list
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
      @emails = Email.where(newsletter_id: @newsletter.id).where.not(admin_email: true).order("created_at DESC").page params[:page]
    end

    def newsletter_params
      params.require(:newsletter).permit(:name, :url, :description, :featured_image, :tag_list, :slug)
    end
end
