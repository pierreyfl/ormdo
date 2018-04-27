# encoding: utf-8
class TokensController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user_from_token!, only: [:create]

=begin
@apiVersion 0.0.1
@api {post} /auth/tokens 01 - Solicitar Token de acesso
@apiName postCreateTokens
@apiGroup 01 - Acesso

@apiExample Header
  HTTP_ACCEPT: application/json

@apiParam {String} email E-mail utilizado para login.
@apiParam {String} password Senha.
@apiParam {String} register Número de registro do aparelho.
@apiParam {String} platform Plataforma (android|ios|web).
@apiParam {String} user_locale Locale do usuário (pt-BR, en, es).

@apiExample Exemplo de Json para request
  {
    "email": "marcos@maini.com.br",
    "password": "123123123",
    "register": "APA91bFd2JaapE_ZCNvB12SS-P2_RQ3Y-c3kkStrBRv6gjIDjbWq9_xRK7ddkK1BrZDAN1l5fK2In8KQGiToGIHzM8RCWmrB97NFDiDlZ_avtzpdYCBgzTeeIFtsvcnve9aEG8C2zVVb4CejlXA6XvqnHmVjE2zOxNgm_oTHE3ZWLA-nFtZUh5A",
    "platform": "android",
    "user_locale": "pt-BR"
  }

@apiSuccessExample Success-Response-Example:
  HTTP/1.1 200 OK
  {
    user: {
      id: 5
      name: "Marcos Junior",
      email: "marcos@maini.com.br",
      user_group: {
        id: 1,
        name: "Administrador"
      },
      clinics: [
        {
          id: 1,
          name: "Clinica 1",
          logo_url: "logo.png"
        }
      ],
      permissions: [
        {
          id: 1,
          can_view: false,
          can_insert: true,
          can_update: true,
          can_destroy: true,
          can_print: false,
          module: {
            id: 1,
            category: "registers",
            name: "dentists",
            module_key: "registers_dentists",
            available: 1,
            mobile: 0
          },
          user_group: {
            id: 1,
            name: "Administrador"
          }
        }
      ]
    },
    device_id: 6,
    token: "x5Qx8qujZfqUV38GJyBv"
  }

@apiErrorExample  Error-Response: Formato inválido
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "format_error":["The request must be json."]
    }
  }
@apiErrorExample  Error-Response: Não informou login ou password
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "request_login_and_password":["The request must contain the user login and password."]
    }
  }
@apiErrorExample  Error-Response: Não informou o Register ID
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "request_device_register":["The request must contain the device register."]
    }
  }
@apiErrorExample  Error-Response: Não informou a plataforma
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "request_device_platform":["The request must contain the device platform."]
    }
  }
@apiErrorExample  Error-Response: Login/Email inválido
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "invalid_login":["Invalid login."]
    }
  }
@apiErrorExample  Error-Response: Senha inválida
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "invalid_password":["Invalid password."]
    }
  }

=end
  def create
    login     = params[:email]
    password  = params[:password]
    register  = params[:register]
    platform  = params[:platform]

    if request.format != :json
      render :status=>406, :json => Api::Error.new('format_error', t('agilib.token_authenticatable.format_error'))
      return
    end

    if register.nil?
      render :status=>401, :json=> Api::Error.new('request_device_register', t('agilib.token_authenticatable.request_device_register'))
      return
    end

    if platform.nil?
      render :status=>401, :json=> Api::Error.new('request_device_platform', t('agilib.token_authenticatable.request_device_platform'))
      return
    end


    if login.nil? or password.nil?
      render :status=>401, :json => Api::Error.new('request_login_and_password', t('agilib.token_authenticatable.request_login_and_password'))
      return
    end

    @user = User.find_by(email: login.downcase)

    if @user.nil?
      render :status=>401, :json=> Api::Error.new('invalid_login', t('agilib.token_authenticatable.invalid_login'))
      return
    end

    valid_password = @user.valid_password?(password)

    unless valid_password
      render :status=> 401, :json=> Api::Error.new('invalid_password', t('agilib.token_authenticatable.invalid_password'))
    else

      Device.where.not(user_id: @user.id).where(register: register)

      @device = @user.devices.find_by(register: register)

      unless @device
        @device = @user.devices.create(register: register, platform: platform, authentication_token: Devise.friendly_token)
      end

      @user.devices.where.not(id: @device.id).delete_all

      @device.ensure_authentication_token
      @device.save!

      if params[:user_locale].presence

        @user.user_locale = params[:user_locale]

        if I18n.available_locales.include?(@user.user_locale.to_sym)
          I18n.locale = @user.user_locale
        else
          I18n.locale = I18n.default_locale
        end

      end

      @user.save!

    end

  end

  def destroy
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

    user_email = param_email_token.presence

    @user = user_email && User.find_by(email: user_email)

    device_register = param_device_register.presence

    @device = @user && device_register && @user.devices.find_by(register: device_register)

    if @device.nil?

      render :status=>401, :json=> Api::Error.new('invalid_token', t('agilib.token_authenticatable.invalid_token'))

    else

      @device.destroy

      sign_out @user
    end
  end

=begin
@apiVersion 0.0.1
@api {get} /auth/tokens/check 02 - Verificar validade do Token
@apiName getTokensCheck
@apiGroup 01 - Acesso

@apiExample Autenticação por Header
  HTTP_ACCEPT: application/json
  X-User-Token: "x7kqavrqwnbg5itmr5BA"
  X-User-Email: "marcos@maini.com.br"
  X-Device-Register: "APA91bFd2JaapE_ZCNvB12SS-P2_RQ3Y-c3kkStrBRv6gjIDjbWq9_xRK7ddkK1BrZDAN1l5fK2In8KQGiToGIHzM8RCWmrB97NFDiDlZ_avtzpdYCBgzTeeIFtsvcnve9aEG8C2zVVb4CejlXA6XvqnHmVjE2zOxNgm_oTHE3ZWLA-nFtZUh5A"

@apiSuccessExample Success-Response-Example:
  HTTP/1.1 200 OK
  {
    user: {
      id: 5
      name: "Marcos Junior",
      email: "marcos@maini.com.br",
      user_group: {
        id: 1,
        name: "Administrador"
      },
      clinics: [
        {
          id: 1,
          name: "Clinica 1",
          logo_url: "logo.png"
        }
      ]
    },
    device_id: 6,
    token: "x5Qx8qujZfqUV38GJyBv"
  }


@apiErrorExample  Error-Response: Token Inválido
  HTTP/1.1 401 Unauthorized
  {
    "errors":{
      "invalid_token":["Invalid Token."]
    }
  }

=end
  def check
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

    user_email = param_email_token.presence

    @user = user_email && User.find_by(email: user_email)

    device_register = param_device_register.presence

    @device = @user && device_register && @user.devices.find_by(register: device_register)

    unless @device && Devise.secure_compare(@device.authentication_token, param_user_token)
      render :status=>401, :json => Api::Error.new('invalid_token', t('agilib.token_authenticatable.invalid_token'))
      return
    end
  end

end
