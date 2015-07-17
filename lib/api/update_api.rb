require_relative 'base_api.rb'

class UpdateApi < BaseApi

  # PATHS
  PROFILE_PATH       = "profiles"
  UPDATE_PATH        = "updates"
  PENDING_PATH       = "#{UPDATE_PATH}/pending.json"
  SENT_PATH          = "#{UPDATE_PATH}/sent.json"
  INTERACTIONS_PATH  = "interactions.json"
  REORDER_PATH       = "#{UPDATE_PATH}/reorder.json"
  SHUFFLE_PATH       = "#{UPDATE_PATH}/shuffle.json"
  CREATE_PATH        = "#{UPDATE_PATH}/create.json"
  UPDATE_STATUS_PATH = "update.json"
  SHARE_PATH         = "share.json"
  DESTROY_PATH       = "destroy.json"
  MOVE_TOP_PATH      = "move_to_top.json"

  def get_update(id)
    return nil unless verify_token
    get_get_response( build_url("#{UPDATE_PATH}/#{id}.json") )
  end

  def get_pending_updates(id, options = {})
    return nil unless verify_token
    get_get_response( build_url("#{PROFILE_PATH}/#{id}/#{PENDING_PATH}", options) )
  end

  def get_sent_updates(id, options = {})
    return nil unless verify_token
    get_get_response( build_url("#{PROFILE_PATH}/#{id}/#{SENT_PATH}", options) )
  end

  def get_interactions(id, options = {})
    return nil unless verify_token
    get_get_response( build_url("#{UPDATE_PATH}/#{id}/#{INTERACTIONS_PATH}", options) )
  end

  def reorder_updates(id, updates_array, options = {})
    return nil unless verify_token
    post_data  = "#{build_options_string(options)}&"
    post_data += updates_array.map { |u| "order[]=#{u}" }.join("&")

    get_post_response( build_url("#{PROFILE_PATH}/#{id}/#{REORDER_PATH}"), post_data )
  end

  def shuffle_updates(id, options = {})
    return nil unless verify_token
    post_data = build_options_string(options)

    get_post_response( build_url("#{PROFILE_PATH}/#{id}/#{SHUFFLE_PATH}"), post_data )
  end

  def create_update(profile_ids, options = {})
    return nil unless verify_token
    post_data  = "#{build_options_string(options)}&"
    post_data += profile_ids.map { |i| "profile_ids[]=#{i}" }.join("&")

    get_post_response( build_url(CREATE_PATH), post_data )
  end

  def update_status(id, options = {})
    return nil unless verify_token
    post_data = build_options_string(options)

    get_post_response( build_url("#{UPDATE_PATH}/#{id}/#{UPDATE_STATUS_PATH}"), post_data )
  end

  def share_update(id)
    return nil unless verify_token
    get_post_response( build_url("#{UPDATE_PATH}/#{id}/#{SHARE_PATH}") )
  end

  def destroy_update(id)
    return nil unless verify_token
    get_post_response( build_url("#{UPDATE_PATH}/#{id}/#{DESTROY_PATH}") )
  end

  def move_to_top(id)
    return nil unless verify_token
    get_post_response( build_url("#{UPDATE_PATH}/#{id}/#{MOVE_TOP_PATH}") )
  end
end
