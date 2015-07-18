require_relative '../../../lib/api/profile_api.rb'

describe ProfileApi do
  let(:profile_api) { build(:profile_api) }
  let(:success_json) { {"success" => "true"} }
  let(:id) { "123456789" }
  let(:days) { ["mon", "tue"] }
  let(:good_sched) do
    [{
      :days  => days,
      :times => ["00:01", "12:23"]
    }]
  end

  let(:bad_sched) do
    [{
      :days => days
    }]
  end

  before(:each) do
    allow_any_instance_of(ProfileApi).to receive(:verify_token).and_return(true)
    allow_any_instance_of(ProfileApi).to receive(:get_post_response).and_return(success_json)
  end

  describe "#update_schedule" do
    it "raises an exception when the schedule is improperly defined" do
      expect { profile_api.update_schedule(id, bad_sched) }.to raise_error
    end

    it "returns succes with JSON response when schedule is properly defined" do
      expect(profile_api.update_schedule(id, good_sched)).to eq(success_json)
    end
  end
end
