require 'spec_helper'

describe ScBackendStatus do
  context 'association' do
    it { should belong_to(:sc_backend) }
  end

  context 'validation' do
    [:code, :status].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      sc_backend_status = Factory(:sc_backend_status)
      should validate_length_of(:code).is_at_most(20)
      should validate_length_of(:status).is_at_least(1).is_at_most(1)
    end

    it do 
      sc_backend_status = Factory(:sc_backend_status)
      should validate_uniqueness_of(:code)
    end

    it "should return error if code is already taken" do
      sc_backend_status1 = Factory(:sc_backend_status, :code => "9933")
      sc_backend_status2 = Factory.build(:sc_backend_status, :code => "9933")
      sc_backend_status2.should_not be_valid
      sc_backend_status2.errors_on(:code).should == ["has already been taken"]
    end
  end
end
