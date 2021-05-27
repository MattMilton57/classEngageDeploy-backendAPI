class Api::V1::StudentsController < ApplicationController
    before_action :set_student, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index]

    # GET /students
    def index
      @students = Student.all
  
      render json: @students
    end
  
    # GET /students/1
    def show
      render json: @student
    end

    def usersStudents
      @students = Student.all
      @usersStudents = @students.where(user_id:set_user)
      render json: @usersStudents
    end
  
    # POST /students
    def create
      @student = Student.new(student_params)
  
      if @student.save
        render json: @student, status: :created, location: @student
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /students/1
    def update
      if @student.update(student_params)
        render json: @student
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /students/1
    def destroy
      @student.destroy
      render json: {message: "student successfully deleted"}
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_student
        @student = Student.find(params[:id])
      end

      def set_user
        @id = params[:user_id]
      end
  
      # Only allow a trusted parameter "white list" through.
      def student_params
        params.require(:student).permit(:name, :user_id)
      end
  
end
