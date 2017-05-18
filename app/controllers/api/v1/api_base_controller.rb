module Api::V1
  class ApiBaseController < ActionController::API
    include Response
    include ExceptionHandler

    before_action :require_login, except: :ping

    def ping
      if current_user.nil?
        render json: {ping: true, user: ''}
      else
        render json: {ping: true, user: current_user.email}
      end
    end

    def current_user
      @current_user ||= User.authenticate_by_token(auth_token)
    end

    def require_login
      if current_user == nil
        json_response({message: 'You must sign in'}, :unauthorized)
      end
    end

    def auth_token
      params[:token] || request.headers["X-AUTH-TOKEN"]
    end

  end
end
