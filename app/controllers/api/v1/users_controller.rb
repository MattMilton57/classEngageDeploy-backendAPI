class Api::V1::UsersController < ApplicationController
    before_action :authorized, except: [:create]

    def index
        @users = User.all
        render json: @users
    end
    
    def profile
        # puts UserSerializer.new(current_user)
        render json: {user: UserSerializer.new(current_user)}
    end
  
    def create
        @user = User.create(user_params)
        if @user.valid?
            # @user.save
            @userToken = encode_userToken(@user)
            # render json: { user: UserSerializer.new(@user) }, status: :created
            render json: { user: UserSerializer.new(@user), jwt: @userToken }

                #use encode_userToken method to do JWT.encode (AppController)
        else
            render json: { error: 'Failed to create new user account' }, status: :not_acceptable
        end
    end
    
    def update 
        @user = User.find(params[:id])
        @user.update(user_params)
        render json: @user
    end

    def destroy
        @user = User.find(params[:id])
        if @user 
            @usersAssesments = Assessment.where(user_id:set_user)
            @usersAssesments.destroy_all
            @usersRegistrations = Registration.where(user_id:set_user)
            @usersRegistrations.destroy_all
            @users_students = Student.where(user_id:set_user)
            @users_students.destroy_all
            @users_classPeriods = ClassPeriod.where(user_id:set_user)
            @users_classPeriods.destroy_all
            @user.destroy 
            render json: {message: "User successfully deleted"}
        else 
            render json: {message: 'Could not delete user'}, status: :not_acceptable
        end
    end

    # def destroy
    #     @user = User.find(params[:id])
    #     if @user 
    #         @user.destroy 
    #         render json: {message: "User successfully deleted"}
    #     else 
    #         render json: {message: 'Could not delete user'}, status: :not_acceptable
    #     end
    # end
    
    private

    def set_user
        @id = params[:user_id]
    end

    def user_params
        params.require(:user).permit(:username, :password, :bio, :avatar)
    end
end
