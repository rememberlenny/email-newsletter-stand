class AddImageToNewslettersController < ApplicationController
  before_action :set_add_image_to_newsletter, only: [:show, :edit, :update, :destroy]

  def index
    @add_image_to_newsletters = AddImageToNewsletter.all
    respond_with(@add_image_to_newsletters)
  end

  def show
    respond_with(@add_image_to_newsletter)
  end

  def new
    @add_image_to_newsletter = AddImageToNewsletter.new
    respond_with(@add_image_to_newsletter)
  end

  def edit
  end

  def create
    @add_image_to_newsletter = AddImageToNewsletter.new(add_image_to_newsletter_params)
    @add_image_to_newsletter.save
    respond_with(@add_image_to_newsletter)
  end

  def update
    @add_image_to_newsletter.update(add_image_to_newsletter_params)
    respond_with(@add_image_to_newsletter)
  end

  def destroy
    @add_image_to_newsletter.destroy
    respond_with(@add_image_to_newsletter)
  end

  private
    def set_add_image_to_newsletter
      @add_image_to_newsletter = AddImageToNewsletter.find(params[:id])
    end

    def add_image_to_newsletter_params
      params[:add_image_to_newsletter]
    end
end
