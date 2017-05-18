module Api::V1::Auth
  class SessionsController < Api::V1::ApiBaseController
    skip_before_action :require_login, only: :create

    def create
      if (params[:email].nil?)
        json_response(error: 'Email is required')
      elsif params[:password].nil?
        json_response(error: 'Password is required')
      else
        @user = User.authenticate(params[:email], params[:password])
        if @user.nil?
          json_response(message: 'Incorrect Email/Password')
        else
          token = @user.auth_token || @user.new_token!
          json_response(token: token)
        end
      end
    end

    def destroy
      current_user.delete_token!
      head :no_content
    end

  end
end
