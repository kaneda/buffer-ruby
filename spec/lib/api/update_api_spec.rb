require_relative '../../../lib/api/update_api.rb'

describe UpdateApi do
  let(:update_api) { build(:update_api) }
  let(:id) { "123456789" }
  let(:path) { "some_path" }

  before(:each) do
    allow_any_instance_of(UpdateApi).to receive(:verify_token).and_return(true)
  end

  describe "#build_profile_url" do
    it "returns a proper profile URL" do
      expected_val = "#{UpdateApi::PROFILE_PATH}/#{id}/#{path}"
      expect(update_api.send(:build_profile_url, id, path)).to include(expected_val)
    end
  end

  describe "#build_update_url" do
    it "returns a proper update URL" do
      expected_val = "#{UpdateApi::UPDATE_PATH}/#{id}/#{path}"
      expect(update_api.send(:build_update_url, id, path)).to include(expected_val)
    end
  end
end
