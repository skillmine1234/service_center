require 'spec_helper'

describe ApiKey do
  context "generate_access_token" do
    it "should generate_access_token" do
      key = Factory(:api_key, :access_token => nil)
      key.access_token.should_not be_nil
    end
  end
end