require_relative 'base_api.rb'

class AuthApi < BaseApi

  # PATHS
  OAUTH_PATH = "oauth2/token.json"

  def get_auth_token
    return nil unless verify_user_code && verify_env_vars

    oauth_url = "#{API_URL}/#{API_VERSION}/#{OAUTH_PATH}"

    post_data = "client_id=#{ENV['BUFFER_KEY']}&" +
      "client_secret=#{ENV['BUFFER_SECRET']}&" +
      "redirect_uri=#{ENV['REDIRECT_URI']}&" +
      "code=#{@user_code}&" +
      "grant_type=authorization_code"

    json_response = get_post_response(oauth_url, post_data)
    if json_response.present? && json_response["access_token"].present?
      json_response["access_token"]
    else
      @error = "Failed to get JSON token, received: #{json_response}"
      nil
    end
  end
end
