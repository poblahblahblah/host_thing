class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # require auth for all controllers
  before_action :authenticate_user!
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }
end
