class SessionsController < Clearance::SessionsController

  def create
    @user = authenticate(params)
    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        flash.now.notice = status.failure_message
        @email = params.dig(:session, :email)
        render template: 'sessions/new', status: :unauthorized
      end
    end
  end
end
