module AuthHelper
  def basic_auth_header
    user = ENV.fetch('AUTH_USER')
    password = ENV.fetch('AUTH_PASSWORD')
    encoded_authorization = ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
    { 'HTTP_AUTHORIZATION' => encoded_authorization }
  end
end
