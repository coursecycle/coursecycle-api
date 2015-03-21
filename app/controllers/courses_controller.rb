class CoursesController < ApplicationController

  def view
    course = Course.find(params[:id])
    render json: course
  end



end