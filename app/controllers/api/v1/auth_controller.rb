class Api::V1::AuthController < ApplicationController
    # skip_before_action :authorized, only: [:create]

    def create
        @user = User.find_by(username: user_login_params[:username])
        @serialized = UserSerializer.new(@user)
        if @user && @user.authenticate(user_login_params[:password])
            @userToken = encode_userToken(@user)
            render json: { user: @serialized, jwt: @userToken }
        else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end


    def show
        @user = current_user
        # user = User.find_by(id: user_id)
        if logged_in?
            render json: {id: @user.id, username: @user.username}
        else
            render json: { error: 'No user could be found'}, status: 401
        end
    end

    private
    def user_login_params
        params.require(:user).permit(:username, :password)
    end
end
