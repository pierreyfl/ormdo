module ResourceDependencies
  extend ActiveSupport::Concern

  included do
    before_action :load_contact, if: :contact_param_exist?
    before_action :load_ad, if: :ad_param_exist?
    before_action :load_region, if: :region_param_exist?

  end

  protected
  def contact_param_exist?
    params[:contact_id].present?
  end

  def ad_param_exist?
    params[:ad_id].present?
  end

  def region_param_exist?
    params[:region_id].present?
  end

  def load_contact
    @resource = Contact.find(params[:contact_id])
  end

  def load_ad
    @resource = Ad.find(params[:ad_id])
  end

  def load_region
    @region = Region.find(params[:region_id])
  end

end