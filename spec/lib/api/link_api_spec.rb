require_relative '../../../lib/api/link_api.rb'

describe LinkApi do
  let(:link_api) { build(:link_api) }
  let(:success_json) { {"shares" => 123456} }
  let(:url) { "http%3A%2F%2Fjbegleiter.com" }

  before(:each) do
    allow_any_instance_of(LinkApi).to receive(:get_get_response).and_return(success_json)
  end

  # Make sure this doesn't blow up, keeping in mind that
  # that get_get_response is tested in the ApiHelpers spec
  describe "#get_shares" do
    it "returns share JSON" do
      expect(link_api.get_shares(url)).to eq(success_json)
    end
  end
end
