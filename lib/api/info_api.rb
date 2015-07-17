require_relative 'base_api.rb'

class InfoApi < BaseApi

  # PATHS
  CONFIG_PATH = "info/configuration.json"

  def get_configuration
    return nil unless verify_token
    get_get_response( build_url(CONFIG_PATH) )
  end
end
