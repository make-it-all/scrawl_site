module Api::V1::Auth
  class UsersController < Api::V1::ApiBaseController
    skip_before_action :require_login, only: :create

    def create
      user = User.new(user_params)
      if user.save
        token = user.new_token!
        render json: {token: token}
      else
        render json: {message: user.errors}, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

  end
end
