class CoursesController < ApplicationController

  # GET /courses/:id
  def view
    course = Course.find(params[:id])
    render json: course
  end

  # GET /courses/:id/instructors
  def instructors
    sections_instructors = Course.includes(:sections => :instructors).find(params[:id]).sections.map{ |s| s.instructors }
    instructors = []
    sections_instructors.each{ |section_instructors| instructors = instructors | section_instructors }
    render json: instructors
  end

  # GET /courses/:id/sections
  def sections
    render json: Course.includes(:sections).find(params[:id]).sections
  end

  # POST /courses/search
  def search

  end

end