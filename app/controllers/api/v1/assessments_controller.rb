class Api::V1::AssessmentsController < ApplicationController
    before_action :set_assessment, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index, :filter,]

    # GET /assessments
    def index
      @assessments = Assessment.all
  
      render json: @assessments
    end
  
    # GET /assessments/1
    def show
      render json: @assessment
    end
  
    # POST /assessments
    def create
      @assessment = Assessment.new(assessment_params)
  
      if @assessment.save
        render json: @assessment, status: :created, location: @assessment
      else
        render json: @assessment.errors, status: :unprocessable_entity
      end
    end
    
    def classAssessments
        @assessments = Assessment.all
        @classesAssessments = @assessments.where(class_period_id:set_class_period)
        render json: @classesAssessments
    end

    def studentAssessments
        @assessments = Assessment.all
        @studentsAssessments = @assessments.where(student_id:set_student)
        render json: @studentsAssessments
    end
  
    # PATCH/PUT /assessments/1
    def update
      if @assessment.update(assessment_params)
        render json: @assessment
      else
        render json: @assessment.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /assessments/1
    def destroy
      @assessment.destroy
      render json: {message: "registration successfully deleted"}
    end

    def deleteStudentAssessments
      @assessments = Assessment.all
      # Assessment.where(student_id:set_student).destroy_all
      @studentsAssessments = @assessments.where(student_id:set_student)
      @studentsAssessments.destroy_all
      render json: {message: "assessments destroyed"}
    end

    def deleteClassPeriodAssessments
      @assessments = Assessment.all
      # Assessment.where(student_id:set_student).destroy_all
      @classPeriodsAssessments = @assessments.where(class_period_id:set_class_period)
      @classPeriodsAssessments.destroy_all
      render json: {message: "class period registrations successfully deleted"}
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_assessment
        @assessment = Assessment.find(params[:id])
      end

      def set_student
        @id = params[:student_id]
      end

      def set_class_period
        @id = params[:class_period_id]
      end
  
      # Only allow a trusted parameter "white list" through.
      def assessment_params
        # params.require(:assessment).permit(:participating)
        params.require(:assessment).permit(:class_period_id, :student_id, :user_id, :participating, :comment)
  
      end
end



