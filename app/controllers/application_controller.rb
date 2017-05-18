class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  before_action :require_login

  before_action do
    if self.class <= Clearance::SessionsController
      layout :clearance_layout
    end
  end
end
