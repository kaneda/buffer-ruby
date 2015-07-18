require_relative '../../../lib/api/user_api.rb'

describe UserApi do
  let(:user_api) { build(:user_api) }
  let(:success_json) { {"key" => "value"} }

  before(:each) do
    allow_any_instance_of(UserApi).to receive(:verify_token).and_return(true)
    allow_any_instance_of(UserApi).to receive(:get_get_response).and_return(success_json)
  end

  # Make sure these don't blow up, keeping in mind that
  # that get_get_response is tested in the ApiHelpers spec
  describe "#get_user_json" do
    it "returns user JSON" do
      expect(user_api.get_user_json).to eq(success_json)
    end
  end

  describe "#deauthorize" do
    it "returns success JSON" do
      expect(user_api.deauthorize).to eq(success_json)
    end
  end
end
