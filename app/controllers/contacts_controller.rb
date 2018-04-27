class ContactsController < ApplicationController
  include ResourceDependencies
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @helpful_contacts = 0
    @contacts = Contact.all
    if (@region.present?)
      @contacts = @region.contacts
    end
    @contacts = @contacts.where(helpful: false)

    @contacts = @contacts.order('IF(ifnull(latitude,0)=0,0,1), name asc')

    filter = filtering_params(params)
    filter.each do |key, value|
      @contacts = @contacts.public_send(key, value) if value.present?
    end

    @contacts = @contacts.paginate(:page => params[:page], :per_page => 20)

    respond_with(@contacts)
  end

  def helpful
    @helpful_contacts = 1
    @contacts = Contact.all
    if (@region.present?)
      @contacts = @region.contacts
    end
    @contacts = @contacts.where(helpful: true)
    @contacts = @contacts.order(:name)

    @contacts = @contacts.paginate(:page => params[:page], :per_page => 20)

    filter = filtering_params(params)

    filter.each do |key, value|
      @contacts = @contacts.public_send(key, value) if value.present?
    end

    respond_to do |format|
        format.html { render :template => "contacts/index.html.erb" }
    end
  end

  def show
    respond_with(@contact)
  end

  def new
    @helpful_contacts = params[:helpful].to_i
    @helpful_contacts = @helpful_contacts == 0 ? false : true

    @contact = Contact.new
    @phones = @contact.phones.build(area: Region.first.ddd)
    @external_links = @contact.external_links.build
    @photos = @contact.photos.build
    @contact.helpful = @helpful_contacts

    respond_with(@contact)
  end

  def edit
    @helpful_contacts = @contact.helpful
    build_dependencies
  end

  def create
    if (@region.present?)
      @contact = @region.contacts.build(contact_params)
    else
      @contact = Contact.new(contact_params)
    end

    if (!@contact.save)
      build_dependencies
    end

    if (@contact.helpful)
      respond_with(@contact, location: helpful_region_contacts_path(@contact.region))
      return
    end

    respond_with(@region, @contact)
  end

  def update
    @helpful_contacts = @contact.helpful
    puts @contact.photos.to_json.blue

    if (!@contact.update(contact_params))
      build_dependencies
    end
    if (@contact.helpful)
      respond_with(@contact, location: helpful_region_contacts_path(@contact.region))
      return
    end
    respond_with(@region, @contact)
  end

  def destroy
    @contact.destroy

    if (@contact.helpful)
      respond_with(@contact, location: helpful_region_contacts_path(@contact.region))
      return
    end

    respond_with(@region, @contact)
  end

  def import
    Contact.import(params[:file], @region)

    respond_with(@region)
  end

  private
    def set_contact
      @contact = @resource = Contact.find(params[:id])
    end

    def build_dependencies
      @contact.contact_types = @contact.contact_types.order(:name)
      @phones = @contact.phones
      if (!@phones.present?)
        @phones = @contact.phones.build
      end

      @external_links = @contact.external_links
      if (!@external_links.present?)
        @external_links = @contact.external_links.build
      end

      @photos = @contact.photos
      if (!@photos.present?)
        @photos = @contact.photos.build
      end
    end

    def filtering_params(params)
      @global_filter = params[:global_filter]
      @region_filter = params[:region_filter]
      @contact_type_filter = params[:contact_type_filter]
      params.slice(:global_filter, :region_filter, :contact_type_filter)
    end

    def contact_params
      params.require(:contact).permit(:name, :open_24, :helpful, :address, :latitude, :longitude, :region_id, :description,
                                      :contact_type_id, :search_field, :address_for_geocoder, :on_call_drugstore,
                                      {contact_type_ids: []}, {photos_attributes: [:file, :id, :main,  :_destroy]},
                                      phones_attributes:[:id, :area, :number, :priority, :carrier],
                                      external_links_attributes:[:id, :link, :name, :link_provider_id, :link_type])
    end
end
