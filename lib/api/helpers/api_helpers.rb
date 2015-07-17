require_relative '../error_codes.rb'

module ApiHelpers
  GOOD_RESPONSE = "200"
  DEFAULT_ERR = "An unknown error occurred, please contact an administrator for assistance"

  def log_or_print(msg, method = :error)
    if @logger.present?
      @logger.send(method, msg)
    else
      puts msg
    end
  end

  def has_data?(response)
    response.present? && response.body.present?
  end

  def parse_data(response)
    begin
      JSON.parse(response.body)
    rescue => e
      Rails.logger.error "Failed to parse JSON return from Buffer: #{e}"
      nil
    end
  end

  def get_http_obj(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    http
  end

  def get_get_response(uri)
    http = get_http_obj(uri)

    req = Net::HTTP::Get.new(uri)
    response = http.request(req)

    if has_data?(response)
      parse_data(response)
    end
  end

  def get_post_response(uri, post_data)
    http = get_http_obj(uri)

    req = Net::HTTP::Post.new(uri)
    req.content_type = "application/x-www-form-urlencoded"
    req.body = post_data
    response = http.request(req)

    if has_data?(response)
      json_response = parse_data(response)
      if json_response.present?
        if response.code == GOOD_RESPONSE
          return json_response["access_token"]
        elsif json_response["error"].present?
          @error = json_response["error"]
        elsif json_response["error_code"].present?
          @error = get_error_message(response.code, json_response["error_code"])
        else
          @error = DEFAULT_ERR
        end
      end
    end
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
