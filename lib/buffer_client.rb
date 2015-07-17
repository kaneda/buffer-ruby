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
    @auth_api.configure(options)
    @user_api.configure(options)
    @profile_api.configure(options)
  end

  def has_error?
    @error.present?
  end

  def get_error
    tmp_error = @error
    @error = nil
    tmp_error
  end

  def error
    @error
  end

  def get_auth_token
    token = @auth_api.get_auth_token
    if @auth_api.has_error?
      @error = @auth_api.get_error
    end

    token
  end

  def get_user_id
    user_id = @user_api.get_user_id
    if @user_api.has_error?
      @error = @user_api.get_error
    end

    user_id
  end

  def get_user_json
    user_json = @user_api.get_user_json
    if @user_api.has_error?
      @error = @user_api.get_error
    end

    user_json
  end

  def get_user_profiles
    profiles = @profile_api.get_profiles
    if @profile_api.has_error?
      @error = @profile_api.get_error
    end

    profiles
  end
end
