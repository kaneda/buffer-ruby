require_relative 'base_api.rb'

class ProfileApi < BaseApi

  # PATHS
  PROFILES_PATH = "profiles.json"

  def get_profiles
    return nil unless verify_token
    get_get_response( build_url(PROFILES_PATH) )
  end
end
