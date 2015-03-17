class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  before_filter :verify_api_key

  private

  def verify_api_key
    puts "I'm here"
    puts params
    puts "I'm leaving"
  end

end
