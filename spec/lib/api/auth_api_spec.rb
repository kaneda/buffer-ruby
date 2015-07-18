require_relative '../../../lib/api/auth_api.rb'

describe AuthApi do
  let(:auth_api) { build(:auth_api) }
  let(:token) { "123456789" }
  let(:good_json) { {"access_token" => token} }

  before(:each) do
    allow_any_instance_of(AuthApi).to receive(:verify_user_code).and_return(true)
    allow_any_instance_of(AuthApi).to receive(:verify_env_vars).and_return(true)
  end

  describe "#get_auth_token" do
    it "returns the access token with a good JSON response" do
      allow_any_instance_of(AuthApi).to receive(:get_post_response).and_return(good_json)
      expect(auth_api.get_auth_token).to eq(token)
    end

    it "returns nil with bad JSON response" do
      allow_any_instance_of(AuthApi).to receive(:get_post_response).and_return(nil)
      expect(auth_api.get_auth_token).to be_nil
    end
  end
end
