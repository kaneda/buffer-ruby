require 'cgi'
require_relative "api/auth_api.rb"
require_relative "api/user_api.rb"
require_relative "api/profile_api.rb"
require_relative "api/update_api.rb"
require_relative "api/link_api.rb"
require_relative "api/info_api.rb"

class BufferClient
  def initialize(options = {})
    @error = nil

    # Initialize the API objects we may use
    @auth_api    = AuthApi.new(options)
    @user_api    = UserApi.new(options)
    @profile_api = ProfileApi.new(options)
    @update_api  = UpdateApi.new(options)
    @link_api    = LinkApi.new(options)
    @info_api    = InfoApi.new(options)

    @api_objects = [
      @auth_api,
      @user_api,
      @profile_api,
      @update_api,
      @link_api,
      @info_api
    ]
  end

  ##################
  # HELPER METHODS #
  ##################

  # Reconfigure API objects
  def configure(options = {})
    @api_objects.each do |api|
      api.configure(options)
    end
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

  ############
  # AUTH API #
  ############

  def get_auth_token
    token = @auth_api.get_auth_token
    record_err(@auth_api)

    token
  end

  ############
  # USER API #
  ############

  def get_user_id
    user_id = @user_api.get_user_id
    record_err(@user_api)

    user_id
  end

  def get_user_json
    user_json = @user_api.get_user_json
    record_err(@user_api)

    user_json
  end

  def deauthorize
    success_json = @user_api.deauthorize
    record_err(@user_api)

    is_success?(success_json)
  end

  ###############
  # PROFILE API #
  ###############

  def get_user_profiles
    profiles = @profile_api.get_profiles
    record_err(@profile_api)

    profiles
  end

  def get_user_profile(id)
    profile = @profile_api.get_profile(id)
    record_err(@profile_api)

    profile
  end

  def get_schedule(id)
    schedule = @profile_api.get_schedule(id)
    record_err(@profile_api)

    schedule
  end

  def update_schedule(id, sched_array)
    sched_array.deep_symbolize_keys!
    success_json = @profile_api.update_schedule(id, sched_array)
    record_err(@profile_api)

    is_success?(success_json)
  end

  ##############
  # UPDATE API #
  ##############

  def get_update(id)
    update_json = @update_api.get_update(id)
    record_err(@update_api)

    update_json
  end

  def get_pending_updates(id, options = {})
    pending_updates_json = @update_api.get_pending_updates(id, options)
    record_err(@update_api)

    pending_updates_json
  end

  def get_sent_updates(id, options = {})
    sent_updates_json = @update_api.get_sent_updates(id, options)
    record_err(@update_api)

    sent_updates_json
  end

  def get_interactions(id, event, options = {})
    # Forces the user to enter a value for event without
    # needing to validate the hash
    options[:event]   = event
    interactions_json = @update_api.get_interactions(id, options)
    record_err(@update_api)

    interactions_json
  end

  def reorder_updates(id, updates_array, options = {})
    new_order_json = @update_api.reorder_updates(id, updates_array, options)
    record_err(@update_api)

    extract_key(new_order_json, "updates")
  end

  def shuffle_updates(id, options = {})
    shuffle_json = @update_api.shuffle_updates(id, options)
    record_err(@update_api)

    extract_key(shuffle_json, "updates")
  end

  def create_update(profile_ids, options = {})
    post_json = @update_api.create_update(profile_ids, options)
    record_err(@update_api)

    post_json
  end

  def update_status(id, text, options = {})
    # Forces the user to enter a value for text without
    # needing to validate the hash
    options[:text] = text
    update_json = @update_api.update_status(id, options)
    record_err(@update_api)

    update_json
  end

  def share_update(id)
    success_json = @update_api.share_update(id)
    record_err(@update_api)

    is_success?(success_json)
  end

  def destroy_update(id)
    success_json = @update_api.destroy_update(id)
    record_err(@update_api)

    is_success?(success_json)
  end

  def move_to_top(id)
    success_json = @update_api.move_to_top(id)
    record_err(@update_api)

    is_success?(success_json)
  end

  ############
  # LINK API #
  ############

  def get_shares(url)
    # Encode URL
    encoded_url = CGI.escape(url)
    share_json = @link_api.get_shares(encoded_url)
    record_err(@link_api)

    if share_json.present? && share_json["shares"].present?
      share_json["shares"]
    end
  end

  ############
  # INFO API #
  ############

  def get_configuration
    info_json = @info_api.get_configuration
    record_err(@info_api)

    info_json
  end

  private

  def is_success?(success_json)
    success_json.present? && success_json.include?("success") && success_json["success"] == true
  end

  def record_err(api)
    @error = api.get_error if api.has_error?
  end

  def extract_key(json, key)
    return json[key] if json.present?
  end
end
