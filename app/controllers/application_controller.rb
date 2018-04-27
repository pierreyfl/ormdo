require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html, :json

  protect_from_forgery with: :null_session

  include TokenAuthenticatableHandler

  include ErrorRescues


end
