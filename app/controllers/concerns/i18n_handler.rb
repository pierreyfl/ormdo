module I18nHandler
  extend ActiveSupport::Concern

  included do
    before_action :configure_i18n
  end


  def configure_i18n
    if current_user

      if I18n.available_locales.include?(current_user.user_locale.to_sym)
        I18n.locale = current_user.user_locale.to_sym
      else
        I18n.locale = I18n.default_locale
      end

    end
  end



end