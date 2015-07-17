require_relative 'base_api.rb'

class ProfileApi < BaseApi

  # PATHS
  PROFILE_PATH   = "profiles"
  PROFILES_PATH  = "#{PROFILE_PATH}.json"
  SCHEDULE_PATH  = "schedules"
  SCHEDULES_PATH = "#{SCHEDULE_PATH}.json"
  UPDATE_PATH    = "#{SCHEDULE_PATH}/update.json"

  def get_profiles
    return nil unless verify_token
    get_get_response( build_url(PROFILES_PATH) )
  end

  def get_profile(id)
    return nil unless verify_token
    get_get_response( build_url("#{PROFILE_PATH}/#{id}.json") )
  end

  def get_schedule(id)
    return nil unless verify_token
    get_get_response( build_url("#{PROFILE_PATH}/#{id}/#{SCHEDULES_PATH}") )
  end

  def update_schedule(id, sched_array)
    return nil unless verify_token

    update_url = build_url("#{PROFILE_PATH}/#{id}/#{UPDATE_PATH}")

    post_data = ""
    sched_array.each_with_index do |sched, index|
      base = "schedules[#{index}]"
      [:days, :times].each do |key|
        sched[key].each do |val|
          post_data += "#{base}[#{key}][]=#{val}&"
        end
      end
    end

    get_post_response(update_url, post_data)
  end
end
