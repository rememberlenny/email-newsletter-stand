class CurationsController < ApplicationController
  respond_to :html, :json
  before_action :set_curation, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :user

  def index
    @curations = Curation.all
    respond_with(@curations)
  end

  def show
    respond_with(@curation)
  end

  def new
    @curation = Curation.new
    respond_with(@curation)
  end

  def edit
  end

  def create
    @curation = Curation.new(curation_params)
    @curation.save
    respond_with(@curation)
  end

  def update
    @curation.update(curation_params)
    respond_with(@curation)
  end

  def destroy
    @curation.destroy
    respond_with(@curation)
  end

  private
    def set_curation
      @curation = Curation.find(params[:id])
    end

    def curation_params
      params.require(:curation).permit(:name, :placement)
    end
end
