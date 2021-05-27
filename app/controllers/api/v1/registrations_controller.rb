class Api::V1::RegistrationsController < ApplicationController
    before_action :set_registration, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index, :filter]
    # before_action :set_class_period, only: [:filter]



    # GET /registrations
    def index
      @registrations = Registration.all
  
      render json: @registrations
    end
  
    # GET /registrations/1
    def show
      render json: @registration
    end

    def filter
      @all = Registration.all
      @filtered = @all.where(class_period_id:set_class_period)
      render json: @filtered
      # render json: set_class_period
    end
  
    # POST /registrations
    def create
      @registration = Registration.new(registration_params)
  
      if @registration.save
        render json: @registration, status: :created, location: @registration
      else
        render json: @registration.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /registrations/1
    def update
      if @registration.update(registration_params)
        render json: @registration
      else
        render json: @registration.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /registrations/1
    def destroy
      @registration.destroy
      render json: {message: "registration successfully deleted"}
    end

    def deleteStudentRegistrations
      @registrations = Registration.all
      # Assessment.where(student_id:set_student).destroy_all
      @studentsRegistrations = @registrations.where(student_id:set_student)
      @studentsRegistrations.destroy_all
      render json: {message: "registration successfully deleted"}
    end

    def deleteClassPeriodRegistrations
      @registrations = Registration.all
      # Assessment.where(student_id:set_student).destroy_all
      @classPeriodsRegistrations = @registrations.where(class_period_id:set_class_period)
      @classPeriodsRegistrations.destroy_all
      render json: {message: "registration successfully deleted"}
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_registration
        @registration = Registration.find(params[:id])
      end

      def set_student
        @id = params[:student_id]
      end

      def set_class_period
        @id = params[:class_period_id]
      end
  
      # Only allow a trusted parameter "white list" through.
      def registration_params
        params.require(:registration).permit(:class_period_id, :student_id, :user_id)
      end
end
