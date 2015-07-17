require_relative 'base_api.rb'

class AuthApi < BaseApi

  # PATHS
  OAUTH_PATH = "oauth2/token.json"

  def get_auth_code
    return nil unless verify_user_code && verify_env_vars

    oauth_url = "#{API_URL}/#{API_VERSION}/#{OAUTH_PATH}"
    uri = URI.parse(oauth_url)

    post_data = "client_id=#{ENV['BUFFER_KEY']}&" +
      "client_secret=#{ENV['BUFFER_SECRET']}&" +
      "redirect_uri=#{Rails.configuration.buffer_redirect_uri}&" +
      "code=#{@user_code}&" +
      "grant_type=authorization_code"

    json_response = get_post_response(uri, post_data)
    if json_response.present?
      json_response["access_token"]
    end
  end
end
