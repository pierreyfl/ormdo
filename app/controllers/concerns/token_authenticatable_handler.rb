module TokenAuthenticatableHandler
  extend ActiveSupport::Concern

  included do
    protected :authenticate_user_from_token!

    before_action :authenticate_user_from_token!
    before_action :authenticate_user!, :unless => :devise_controller?

    skip_before_action :verify_authenticity_token
  end

  def authenticate_user_from_token!
    param_user_token      = params[:user_token]
    param_email_token     = params[:user_email]
    param_device_register = params[:device_register]

    if user_token = param_user_token.blank? && request.headers["X-User-Token"]
      param_user_token = user_token
    end

    if user_email = params[:user_email].blank? && request.headers["X-User-Email"]
      param_email_token = user_email
    end

    if device_register = params[:device_register].blank? && request.headers["X-Device-Register"]
      param_device_register = device_register
    end

    unless Rails.env.production?
      puts '=HEADERS===================================================================================================='.green
      puts "#{'X-User-Token:'.cyan.bold} #{param_user_token}"
      puts "#{'X-User-Email:'.cyan.bold} #{param_email_token}"
      puts "#{'X-Device-Register:'.cyan.bold} #{param_device_register}"
      puts '============================================================================================================'.green
    end

    user_email = param_email_token.presence

    user = user_email && User.find_by(email: user_email)

    device_register = param_device_register.presence

    device = user && device_register && user.devices.find_by(register: device_register)

    if device && Devise.secure_compare(device.authentication_token, param_user_token)
      sign_in :user, user, store: false
      # SessionGateway.user = user
    end

  end

end