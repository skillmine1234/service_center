require 'spec_helper'

describe ScBackend do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:sc_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:code, :do_auto_shutdown, :max_consecutive_failures, :window_in_mins, :max_window_failures, 
     :do_auto_start, :min_consecutive_success, :min_window_success].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      sc_backend = Factory(:sc_backend, :approval_status => 'A')

      should validate_length_of(:code).is_at_most(20)
      should validate_length_of(:do_auto_shutdown).is_at_least(1).is_at_most(1)
      should validate_length_of(:do_auto_start).is_at_least(1).is_at_most(1)
    end

    it do
      should validate_inclusion_of(:window_in_mins).in_array([1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60])
    end

    it do 
      sc_backend = Factory(:sc_backend, :approval_status => 'A')
      should validate_uniqueness_of(:code).scoped_to(:approval_status)
    end

    it "should return error if code is already taken" do
      sc_backend1 = Factory(:sc_backend, :code => "9933", :approval_status => 'A')
      sc_backend2 = Factory.build(:sc_backend, :code => "9933", :approval_status => 'A')
      sc_backend2.should_not be_valid
      sc_backend2.errors_on(:code).should == ["has already been taken"]
    end

    it "should return error when window_in_mins < 1" do
      sc_backend1 = Factory.build(:sc_backend, :window_in_mins => 0)
      sc_backend1.should_not be_valid
      sc_backend1.errors_on(:window_in_mins).should == ["Allowed Values: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60"]

      sc_backend2 = Factory.build(:sc_backend, :window_in_mins => -1)
      sc_backend2.should_not be_valid
      sc_backend2.errors_on(:window_in_mins).should == ["Allowed Values: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60"]
    end

    it "should return error when window_in_mins > 60" do
      sc_backend1 = Factory.build(:sc_backend, :window_in_mins => 61)
      sc_backend1.should_not be_valid
      sc_backend1.errors_on(:window_in_mins).should == ["Allowed Values: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60"]
    end

    it "should return error when window_in_mins is not divisor of 60" do
      sc_backend1 = Factory.build(:sc_backend, :window_in_mins => 7)
      sc_backend1.should_not be_valid
      sc_backend1.errors_on(:window_in_mins).should == ["Allowed Values: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60"]
    end
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      sc_backend1 = Factory(:sc_backend, :approval_status => 'A') 
      sc_backend2 = Factory(:sc_backend, :code => '9999')
      sc_backends = ScBackend.all
      ScBackend.all.should == [sc_backend1]
      sc_backend2.approval_status = 'A'
      sc_backend2.save
      ScBackend.all.should == [sc_backend1,sc_backend2]
    end
  end

  context "check_email_addresses" do 
    it "should validate email address" do 
      sc_backend = Factory.build(:sc_backend, :alert_email_to => "1234;esesdgs")
      sc_backend.should_not be_valid
      sc_backend.errors_on("alert_email_to").should == ["is invalid, expected format is abc@def.com"]
      
      sc_backend = Factory.build(:sc_backend, :alert_email_to => "foo@ruby.com;abe@def.com")
      sc_backend.should be_valid
    end
  end
end
