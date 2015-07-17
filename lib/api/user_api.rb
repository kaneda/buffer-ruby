require_relative 'base_api.rb'

class UserApi < BaseApi

  # PATHS
  USER_PATH = "user.json"

  def get_user_id
    get_user_json["id"] rescue nil
  end

  def get_user_json
    return nil unless verify_token
    get_get_response( build_url(USER_PATH) )
  end
end
