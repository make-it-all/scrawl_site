class PagesController < ApplicationController
  skip_before_action :require_login

  def help
    render layout: false
  end
end
