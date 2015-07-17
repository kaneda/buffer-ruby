require_relative 'base_api.rb'

class ProfileApi < BaseApi

  # PATHS
  PROFILES_PATH = "profiles.json"

  def get_profiles
    return nil unless verify_token

    profile_url = "#{API_URL}/#{API_VERSION}/#{PROFILES_PATH}?access_token=#{@auth_token}"
    get_get_response(profile_url)
  end
end
