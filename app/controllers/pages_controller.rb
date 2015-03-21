# This controller is responsible for all pages that have views corresponding to them for the API
class PagesController < ApplicationController
  skip_before_filter :verify_api_key

  def index

  end

end