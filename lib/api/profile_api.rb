class ProfileApi < BaseApi

  # PATHS
  PROFILES_PATH = "profiles.json"

  def get_profiles
    return nil unless verify_token

    profile_url = "#{API_URL}/#{API_VERSION}/#{PROFILES_PATH}?access_token=#{@auth_code}"
    uri = URI.parse(profile_url)

    get_get_response(uri)
  end
end
