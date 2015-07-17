require_relative 'base_api.rb'

class UserApi < BaseApi

  # PATHS
  USER_PATH = "user.json"

  def get_user_id
    get_user_json["id"] rescue nil
  end

  def get_user_json
    return nil unless verify_token

    user_url = "#{API_URL}/#{API_VERSION}/#{USER_PATH}?access_token=#{@auth_token}"
    uri = URI.parse(user_url)

    get_get_response(uri)
  end
end
