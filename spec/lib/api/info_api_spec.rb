require_relative '../../../lib/api/info_api.rb'

describe InfoApi do
  let(:info_api) { build(:info_api) }
  let(:success_json) { {"info" => "info_and_stuff"} }

  before(:each) do
    allow_any_instance_of(InfoApi).to receive(:verify_token).and_return(true)
    allow_any_instance_of(InfoApi).to receive(:get_get_response).and_return(success_json)
  end

  # Make sure this doesn't blow up, keeping in mind that
  # that get_get_response is tested in the ApiHelpers spec
  describe "#get_configuration" do
    it "returns configuration JSON" do
      expect(info_api.get_configuration).to eq(success_json)
    end
  end
end
