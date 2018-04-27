module ContactDependencies
  extend ActiveSupport::Concern

  included do
    before_action :load_contact, if: :contact_param_exist?
  end

  protected
  def contact_param_exist?
    params[:contact_id].present?
  end

  def load_contact
    @contact = Contact.find(params[:contact_id])
  end

end