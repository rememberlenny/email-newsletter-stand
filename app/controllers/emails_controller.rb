class EmailsController < ApplicationController
  respond_to :html, :json
  before_action :set_email, only: [:show, :edit, :update, :destroy]
  skip_authorization_check
  skip_before_action :authenticate_user!

  def index
    if params[:tag]
      @emails = Email.tagged_with(params[:tag])
    else
      @emails = Email.all
    end
    respond_with(@emails)
  end

  def show
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
      @email = Email.find(params[:id])
    end

    def email_params
      params.require(:email).permit( :newsletter_id, :to, :from, :subject, :body, :raw_text, :raw_html, :raw_body, :headers, :raw_headers)
    end
end
