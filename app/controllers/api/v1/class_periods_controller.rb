class Api::V1::ClassPeriodsController < ApplicationController
    before_action :set_class_period, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index, :filter, :students]
  
    # GET /class_periods
    def index
      @class_periods = ClassPeriod.all
  
      render json: @class_periods
    end
  
    # GET /class_periods/1
    def show
      render json: @class_period
    end

    def filter
        @all = ClassPeriod.all
        @filtered = @all.where(user_id:set_user)
        # render json: set_user
        render json: @filtered
    end

    def students
      @registrations = Registration.all
      @filteredReg = @registrations.where(class_period_id:set_class_search)
      @students = Student.all
      @classList = []
      @filteredReg.each { |reg| @students.each { |s| if s.id == reg.student_id then @classList.push(s) end }}
      render json: @classList
    end
  
    # POST /class_periods
    def create
      @class_period = ClassPeriod.new(class_period_params)
  
      if @class_period.save
        render json: @class_period
      else
        render json: @class_period.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /class_periods/1
    def update
      if @class_period.update(class_period_params)
        render json: @class_period
      else
        render json: @class_period.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /class_periods/1
    def destroy
      @class_period.destroy
      render json: {message: "class period successfully deleted"}
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_class_period
        @class_period = ClassPeriod.find(params[:id])
      end

      def set_user
        @id = params[:user_id]
      end

      def set_class_search
        @id = params[:class_period_id]
      end
  
      # Only allow a trusted parameter "white list" through.
      def class_period_params
        params.require(:class_period).permit(:subject, :user_id, :period, :level, :max)
      end
  end