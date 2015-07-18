require 'action_dispatch'
require 'uri'
require_relative '../../../../lib/api/helpers/api_helpers.rb'

describe ApiHelpers do
  let(:base_api) { build(:base_api) }
  let(:options) do
    {
      :key   => "value",
      :key_2 => "value_2"
    }
  end

  let(:err) { "An error" }

  describe "#build_options_string" do
    let(:path_regex) do
      /\A(\w+=[\w\d]+(&\w+=[\w\d]+)+)*\Z/
    end

    it "returns a string representing a valid path" do
      expect(base_api.build_options_string(options)).to match(path_regex)
    end
  end

  describe "#build_url" do
    let(:path) { "some_path" }
    let(:auth_tok) { "123456789" }

    it "returns a valid URL when given only a path" do
      expect(base_api.build_url(path, {}, false)).to match(URI::regexp)
    end

    it "returns a valid URL when given a path and options" do
      expect(base_api.build_url(path, options, false)).to match(URI::regexp)
    end

    it "returns a valid URL when given a path and an auth token" do
      base_api.instance_variable_set(:@auth_token, auth_tok)

      expect(base_api.build_url(path)).to match(URI::regexp)
    end

    it "returns a valid URL when given a path, options, and an auth token" do
      base_api.instance_variable_set(:@auth_token, auth_tok)

      expect(base_api.build_url(path, options)).to match(URI::regexp)
    end
  end

  describe "#set_err" do
    let(:response_code) { "403" }
    let(:err) { "An error" }
    let(:err_2) { "A second err" }
    let(:json_with_error) { { "error" => err } }
    let(:json_with_code) { { "code" => "1001" } }
    let(:json_with_other) { { "other" => "stuff" } }

    it "returns the default error when response is blank" do
      expect(base_api.set_err(response_code, {})).to eq(ApiHelpers::DEFAULT_ERR)
    end

    it "returns an error when the error key is present in the response" do
      expect(base_api.set_err(response_code, json_with_error)).to eq(err)
    end

    it "returns another error when only the code key is present" do
      allow_any_instance_of(BaseApi).to receive(:get_error_message).and_return(err_2)
      expect(base_api.set_err(response_code, json_with_code)).to eq(err_2)
    end

    it "returns the default error when response is present but neither error nor code is present" do
      expect(base_api.set_err(response_code, json_with_other)).to eq(ApiHelpers::DEFAULT_ERR)
    end
  end

  describe "#has_data?" do
    let(:empty_response) do
      ActionDispatch::Response.new(500, {}, "")
    end

    let(:valid_response) do
      ActionDispatch::Response.new(200, {}, "A body")
    end

    it "returns false when passed a blank response" do
      expect(base_api.has_data?(empty_response)).to eq(false)
    end

    it "returns true when passed a response with a body" do
      expect(base_api.has_data?(valid_response)).to eq(true)
    end
  end

  describe "#parse_data" do
    let(:bad_json) { '{"foo": "bar"' }
    let(:bad_json_err) { "Failed to parse JSON return from Buffer" }
    let(:bad_response) do
      ActionDispatch::Response.new(403, {}, bad_json)
    end

    let(:good_json) { "#{bad_json} }" }
    let(:good_response) do
      ActionDispatch::Response.new(200, {}, good_json)
    end

    it "returns nil and sets @error if the response is invalid JSON" do
      json = base_api.parse_data(bad_response)
      expect(json).to be_nil
      expect(base_api.error).to include(bad_json_err)
    end

    it "returns a hash when passed good JSON" do
      json = base_api.parse_data(good_response)
      expect(json).to be_present
      expect(json.is_a?(Hash)).to eq(true)
    end
  end

  describe "#get_error_message" do
    let(:event_err) { "Event type not supported." }
    let(:http_code) { "400" }
    let(:err_code) { "1029" }

    it "returns the event err when the given codes are passed" do
      expect(base_api.get_error_message(http_code, err_code)).to eq(event_err)
    end

    it "returns the default error when the http code is unknown" do
      expect(base_api.get_error_message("10101", err_code)).to eq(ApiHelpers::DEFAULT_ERR)
    end

    it "returns the default error when the error code is unknown" do
      expect(base_api.get_error_message(http_code, "10101")).to eq(ApiHelpers::DEFAULT_ERR)
    end
  end
end
