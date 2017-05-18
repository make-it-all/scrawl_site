class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  before_action :require_login

  layout :layout_for_clearance


  def layout_for_clearance
    if self.class <= Clearance::SessionsController
      'clearance_layout'
    else
      'application'
    end
  end
end
