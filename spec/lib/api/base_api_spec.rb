require_relative '../../../lib/api/base_api.rb'

describe BaseApi do
  let(:base_api) { build(:base_api) }
  let(:err) { "An error" }

  describe "#configure" do
    let(:new_user_code) { "987654321" }
    let(:new_auth_token) { "abc98764321" }

    it "updates the user code" do
      base_api.configure({:user_code => new_user_code})
      expect(base_api.instance_variable_get(:@user_code)).to eql(new_user_code)
    end

    it "updates the auth token" do
      base_api.configure({:auth_token => new_auth_token})
      expect(base_api.instance_variable_get(:@auth_token)).to eql(new_auth_token)
    end

    it "ignores updates that are nil or blank" do
      base_api.configure({:auth_token => "", :user_code => ""})
      expect(base_api.instance_variable_get(:@auth_token)).to_not eq(new_auth_token)
      expect(base_api.instance_variable_get(:@user_code)).to_not eq(new_user_code)
    end
  end

  describe "#has_error?" do
    it "returns false when error is nil or empty" do
      expect(base_api.has_error?).to eq(false)
    end

    it "returns true when error is present" do
      base_api.instance_variable_set(:@error, err)
      expect(base_api.has_error?).to eq(true)
    end
  end

  describe "#get_error" do
    before(:each) do
      base_api.instance_variable_set(:@error, err)
    end

    it "returns the error" do
      expect(base_api.get_error).to eq(err)
    end

    it "wipes the error" do
      base_api.get_error

      expect(base_api.error).to be_nil
    end
  end

  describe "#verify_token" do
    it "returns true when auth token is present" do
      expect(base_api.send(:verify_token)).to eq(true)
    end

    it "returns false when auth token is nil or empty" do
      base_api.instance_variable_set(:@auth_token, nil)
      expect(base_api.send(:verify_token)).to eq(false)
    end
  end

  describe "#verify_user_code" do
    it "returns true when user_code is present" do
      expect(base_api.send(:verify_user_code)).to eq(true)
    end

    it "returns false when user_code is nil or empty" do
      base_api.instance_variable_set(:@user_code, nil)
      expect(base_api.send(:verify_user_code)).to eq(false)
    end
  end

  describe "#verify_env_vars" do
    before(:each) do
      ENV["BUFFER_KEY"]    = "a value"
      ENV["BUFFER_SECRET"] = "a value"
    end

    it "returns true when all env vars are present" do
      expect(base_api.send(:verify_env_vars)).to eq(true)
    end

    it "returns false when BUFFER_KEY is nil or empty" do
      ENV["BUFFER_KEY"] = nil
      expect(base_api.send(:verify_env_vars)).to eq(false)
    end

    it "returns false when BUFFER_SECRET is nil or empty" do
      ENV["BUFFER_SECRET"] = nil
      expect(base_api.send(:verify_env_vars)).to eq(false)
    end
  end
end
