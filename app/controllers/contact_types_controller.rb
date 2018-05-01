class ContactTypesController < ApplicationController
  before_action :set_contact_type, only: [:show, :edit, :update, :destroy]

  def index
    @contact_types = ContactType.includes(:parent).where('ifnull(parent_contact_type_id,0) > 0').paginate(:page => params[:page], :per_page => 20)

    if params[:parent_filter].present? && params[:parent_filter].to_i > 0
      @contact_types = @contact_types.where(parent_contact_type_id: params[:parent_filter].to_i)
    end

    @contact_types = @contact_types.order('name')
    @errors = []
    respond_with(@contact_types)
  end

  def show
    respond_with(@contact_type)
  end

  def new
    @contact_type = ContactType.new
    respond_with(@contact_type)
  end

  def edit
  end

  def create
    @contact_type = ContactType.new(contact_type_params)
    @contact_type.save
    respond_with(@contact_type)
  end

  def update
    @contact_type.update(contact_type_params)
    respond_with(@contact_type)
  end

  def destroy
    @contact_type.destroy
    @errors = @contact_type.errors
    if @errors.any?
      respond_with(@contact_type, alert: @errors.messages[:base].first)
    else
      respond_with(@contact_type)
    end
  end

  private
    def set_contact_type
      @contact_type = ContactType.find(params[:id])
    end

    def contact_type_params
      params.require(:contact_type).permit(:name, :parent_contact_type_id, :deleted_at,:uploader)
    end
end
