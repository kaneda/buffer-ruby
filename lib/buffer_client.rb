require "net/http"
require "uri"
require_relative "api/auth_api.rb"
require_relative "api/user_api.rb"
require_relative "api/profile_api.rb"

class BufferClient
  def initialize(options = {})
    @error = nil

    # Initialize the API objects we may use
    @auth_api    = AuthApi.new(options)
    @user_api    = UserApi.new(options)
    @profile_api = ProfileApi.new(options)
  end

  # Reconfigure API objects
  def configure(options = {})
    @auth_api    = AuthApi.configure(options)
    @user_api    = UserApi.configure(options)
    @profile_api = ProfileApi.configure(options)
  end

  def error
    @error
  end

  def get_auth_token
    @auth_api.get_auth_token
  end

  def get_user_id
    @user_api.get_user_id
  end

  def get_user_json
    @profile_api.get_user_json
  end

  def get_user_profiles
    ProfileApi.get_profiles
  end
end
