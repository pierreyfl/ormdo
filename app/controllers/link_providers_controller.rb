class LinkProvidersController < ApplicationController
  before_action :set_link_provider, only: [:show, :edit, :update, :destroy]

  def index
    @link_providers = LinkProvider.all
    respond_with(@link_providers)
  end

  def show
    respond_with(@link_provider)
  end

  def new
    @link_provider = LinkProvider.new
    respond_with(@link_provider)
  end

  def edit
  end

  def create
    @link_provider = LinkProvider.new(link_provider_params)
    @link_provider.save
    respond_with(@link_provider)
  end

  def update
    @link_provider.update(link_provider_params)
    respond_with(@link_provider)
  end

  def destroy
    @link_provider.destroy
    respond_with(@link_provider)
  end

  private
    def set_link_provider
      @link_provider = LinkProvider.find(params[:id])
    end

    def link_provider_params
      params.require(:link_provider).permit(:name)
    end
end
