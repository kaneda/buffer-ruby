require_relative '../error_codes.rb'
require_relative '../../buffer_vars.rb'

module ApiHelpers
  include BufferVars

  GOOD_RESPONSE = "200"
  DEFAULT_ERR = "An unknown error occurred, please contact an administrator for assistance"

  def log_or_print(msg, method = :error)
    if @logger.present?
      @logger.send(method, msg)
    else
      puts msg
    end
  end

  def build_options_string(options = {})
    options.collect { |k, v| "#{k}=#{v}" }.join("&")
  end

  def build_url(path, options = {}, auth_token = true)
    url            = "#{API_URL}/#{API_VERSION}/#{path}"
    options_string = build_options_string(options)
    token_param    = "access_token=#{@auth_token}"

    if options_string.present?
      url += "?#{options_string}"
      url += "&#{token_param}" if auth_token
    elsif auth_token
      url += "?#{token_param}"
    end

    url
  end

  def has_data?(response)
    response.present? && response.body.present?
  end

  def set_err(json_response)
    if json_response.present?
      if json_response["error"].present?
        @error = json_response["error"]
      elsif json_response["code"].present?
        @error = get_error_message(response.code, json_response["code"])
      else
        @error = DEFAULT_ERR
      end
    else
      @error = DEFAULT_ERR
    end
  end

  def parse_data(response)
    return nil unless has_data?(response)

    begin
      json_response = JSON.parse(response.body)
    rescue => e
      Rails.logger.error "Failed to parse JSON return from Buffer: #{e}"
    end

    if response.code == GOOD_RESPONSE
      return json_response
    else
      set_err(json_response)
    end
  end

  def get_http_obj(url)
    uri              = URI.parse(url)
    http             = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    [ uri, http ]
  end

  def get_get_response(url)
    uri, http = get_http_obj(url)

    req = Net::HTTP::Get.new(uri)
    response = http.request(req)

    parse_data(response)
  end

  def get_post_response(url, post_data = "")
    uri, http = get_http_obj(url)

    req = Net::HTTP::Post.new(uri)
    req.content_type = "application/x-www-form-urlencoded"
    req.body = post_data
    response = http.request(req)

    parse_data(response)
  end

  def get_error_message(http_code, error_code)
    code_array = ErrorCodes::CODE_MAP[http_code]

    if code_array.present?
      code_array[error_code] || DEFAULT_ERR
    else
      DEFAULT_ERR
    end
  end
end
