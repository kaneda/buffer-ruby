require_relative '../../../lib/api/update_api.rb'

describe UpdateApi do
  let(:update_api) { build(:update_api) }
  let(:id) { "123456789" }
  let(:path) { "some_path" }
  let(:return_json) { { :key => "value" } }

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

  # Make sure these don't blow up, keeping in mind that
  # that get_get_response is tested in the ApiHelpers spec
  describe "#gets" do
    before(:each) do
      allow_any_instance_of(UpdateApi).to receive(:get_get_response).and_return(return_json)
    end

    describe "#get_update" do
      it "doesn't blow up when invoked" do
        expect(update_api.get_update(id)).to eq(return_json)
      end
    end

    describe "#get_pending_updates" do
      it "doesn't blow up when invoked" do
        expect(update_api.get_pending_updates(id)).to eq(return_json)
      end
    end

    describe "#get_sent_updates" do
      it "doesn't blow up when invoked" do
        expect(update_api.get_sent_updates(id)).to eq(return_json)
      end
    end

    describe "#get_interactions" do
      it "doesn't blow up when invoked" do
        expect(update_api.get_interactions(id)).to eq(return_json)
      end
    end
  end

  describe "#posts" do
    before(:each) do
      allow_any_instance_of(UpdateApi).to receive(:get_post_response).and_return(return_json)
    end

    describe "#reorder_updates" do
      let(:updates_array) { [ id, id, id ] }

      it "doesn't blow up when invoked" do
        expect(update_api.reorder_updates(id, updates_array)).to eq(return_json)
      end
    end

    describe "#shuffle_updates" do
      it "doesn't blow up when invoked" do
        expect(update_api.shuffle_updates(id)).to eq(return_json)
      end
    end

    describe "#create_update" do
      let(:profile_ids) { [ id, id, id ] }

      it "doesn't blow up when invoked" do
        expect(update_api.create_update(profile_ids)).to eq(return_json)
      end
    end

    describe "#update_status" do
      it "doesn't blow up when invoked" do
        expect(update_api.update_status(id)).to eq(return_json)
      end
    end

    describe "#share_update" do
      it "doesn't blow up when invoked" do
        expect(update_api.share_update(id)).to eq(return_json)
      end
    end

    describe "#destroy_update" do
      it "doesn't blow up when invoked" do
        expect(update_api.destroy_update(id)).to eq(return_json)
      end
    end

    describe "#move_to_top" do
      it "doesn't blow up when invoked" do
        expect(update_api.move_to_top(id)).to eq(return_json)
      end
    end
  end
end
