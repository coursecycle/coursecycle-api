class InstructorsController < ApplicationController

  # GET /instructors/:id
  def view
    render json: Instructor.find(params[:id])
  end

  # GET /instructors/:id/courses
  def courses
    render json: Instructor.includes({:sections => :course}).find(params[:id]).sections.map{ |s| s.course }.uniq
  end

end