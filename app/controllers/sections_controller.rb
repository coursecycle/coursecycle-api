class SectionsController < ApplicationController

  # GET /courses/:id/sections
  def index
    render json: Course.includes(:sections).find(params[:id]).sections
  end

end