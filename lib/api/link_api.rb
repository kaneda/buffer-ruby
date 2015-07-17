require_relative 'base_api.rb'

class LinkApi < BaseApi

  # PATHS
  SHARES_PATH = "links/shares.json"

  def get_shares(encoded_url)
    get_get_response( build_url("#{SHARES_PATH}?url=#{encoded_url}", {}, false) )
  end
end
