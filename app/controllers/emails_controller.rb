class EmailsController < ApplicationController
  respond_to :html, :json
  before_action :set_email, only: [:links, :show, :edit, :update, :destroy]
  skip_authorization_check
  skip_before_action :authenticate_user!



  def index
    @has_search = true
    if params[:tag]
      @emails = Email.tagged_with(params[:tag]).page params[:page]
    else
      @emails = Email.all.where.not(admin_email: true).order('created_at DESC').page params[:page]
    end
    respond_with(@emails)
  end

  def links
    @newsletter = Newsletter.find @email.newsletter_id
    @links = Links.where(email_id: @email.id)
    respond_with(@links)
  end

  def show
    @newsletter = Newsletter.find @email.newsletter_id
    @set_title = @email.subject + ' | ' + @newsletter.name
    @set_meta_description = @newsletter.description
    @set_meta_keyword = @newsletter.tag_list
    @set_meta_keyword << @email.tag_list
    @related_emails = Email.tagged_with(@set_meta_keyword, any: true).limit(10)
    @links = Links.where(email_id: @email.id)
    respond_with(@email)
  end

  def new
    @email = Email.new
    respond_with(@email)
  end

  def edit
  end

  def create
    @email = Email.new(email_params)
    @email.save
    respond_with(@email)
  end

  def update
    @email.update(email_params)
    respond_with(@email)
  end

  def destroy
    @email.destroy
    respond_with(@email)
  end

  private
    def set_email
      @email = Email.friendly.find(params[:id])
    end

    def email_params
      params.require(:email).permit( :slug, :newsletter_id, :to, :from, :subject, :body, :raw_text, :raw_html, :raw_body, :headers, :raw_headers, :tag_list)
    end
end
