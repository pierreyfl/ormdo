class AdsController < ApplicationController
  before_action :load_types
  before_action :load_positions
  before_action :load_contacts
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  def index
    @ads = Ad.all

    filter = filtering_params(params)
    filter.each do |key, value|
      @ads = @ads.public_send(key, value) if value.present?
    end

    @ads = @ads.paginate(:page => params[:page], :per_page => 20)

    respond_with(@ads)
  end

  def show
    respond_with(@ad)
  end

  def new
    @ad = Ad.new
    @external_links = @ad.external_links.build
    @photo = @ad.photos.build

    respond_with(@ad)
  end

  def edit
    build_dependencies
  end

  def create
    @ad = Ad.new(ad_params)
    if !@ad.save
      build_dependencies
    end
    respond_with(@ad)
  end

  def update
    if !@ad.update(ad_params)
      build_dependencies
    end
    respond_with(@ad)
  end

  def destroy
    @ad.destroy
    respond_with(@ad)
  end

  private
    def set_ad
      @ad = @resource = Ad.find(params[:id])
    end

    def load_types
      @view_types = Ad.view_types
      @visit_types = Ad.visit_types
    end

    def load_contacts
      @contacts = Contact.where('helpful = false')
    end

    def load_positions
      @positions = Ad.positions
    end

    def build_dependencies
      @external_links = @ad.external_links
      if (!@external_links.present?)
        @external_links = @ad.external_links.build
      end

      @photo = @ad.photos.first
      if (!@photo.present?)
        @photo = @ad.photos.build
      end
    end

    def filtering_params(params)
      @global_filter = params[:global_filter]
      @start_date_after_filter = params[:start_date_after_filter]
      @end_date_before_filter = params[:end_date_before_filter]
      @position_filter = params[:position_filter]

      params.slice(:global_filter, :start_date_after_filter, :end_date_before_filter, :position_filter)
    end

    def ad_params
      params.require(:ad).permit(:advertiser, :view_type, :visit_type, :title, :description,
            :position, :start_date, :end_date, :deleted_at, :contact_id, :region_id, :keyword,
            external_links_attributes:[:id, :link, :link_provider_id, :link_type],
            sponsorship_attributes: [:id], photos_attributes: [:id, :file])
    end
end
