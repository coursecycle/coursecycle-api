class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  before_filter :verify_api_key

  private

  def verify_api_key
    authorization = request.headers['Authorization']
    if authorization.nil?
      head :unauthorized
    else
      api_key = /api_key="([^)]*)"/.match(authorization).captures
      account = Account.find_by(:api_key => api_key)
      if account.nil?
        head :unauthorized
      end
    end
  end

end
