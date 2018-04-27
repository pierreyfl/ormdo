class ExternalLinksController < ApplicationController
  include ResourceDependencies
  before_action :set_external_link, only: [:show, :edit, :update, :destroy]

  def index
    # @contacts = @contacts.joins(:contact_type).order('contact_types.name')
    @external_links = @resource.external_links.all
    @external_links = @external_links.order('link_type')
    respond_with(@external_links)
  end

  def show
    respond_with(@external_link)
  end

  def new
    @external_link = @resource.external_links.build
    respond_with(@external_link)
  end

  def edit
  end

  def create
    @external_link = @resource.external_links.build(external_link_params)
    @external_link.save
    if @external_link.valid?
      @resource.external_links << @external_link
    end
    respond_with(@resource, @external_link)
  end

  def update
    @external_link.update(external_link_params)
    respond_with(@resource, @external_link)
  end

  def destroy
    @external_link.destroy

    if (@resource.present?)
      @resource.touch
    end

    respond_with(@resource, @external_link)
  end

  private
    def set_external_link
      @external_link = @resource.external_links.find(params[:id])
    end

    def external_link_params
      params.require(:external_link).permit(:link, :link_provider_id, :link_type, :name)
    end
end
