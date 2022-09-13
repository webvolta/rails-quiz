class Api::V1::AuthController < Api::V1::BaseController
    include ApiAuthenticable
  
    skip_before_action :verify_authenticity_token
  
    def login
      token = user_login
      if token[:is_valid]
        render json: token
      else
        render json: { message: 'Invalid email or password' }
      end
    end
end
