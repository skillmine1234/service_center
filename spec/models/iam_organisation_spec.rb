require 'spec_helper'
require 'flexmock/test_unit'

describe IamOrganisation do
  include HelperMethods
  
  before(:each) do
    mock_ldap
  end

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_many(:iam_audit_logs) }
  end

  context "validation" do
    [:name, :org_uuid, :on_vpn, :is_enabled, :email_id].each do |att|
      it { should validate_presence_of(att) }
    end

    it do 
      iam_organisation = Factory(:iam_organisation, :approval_status => 'A')
      should validate_uniqueness_of(:org_uuid).scoped_to(:approval_status)   
    end

    it do
      iam_organisation = Factory(:iam_organisation)
      should validate_length_of(:on_vpn).is_at_least(1).is_at_most(1)
    end

    it "should validate format of source_ips" do
      iam_organisation = Factory.build(:iam_organisation, :source_ips => "123@78.89:91\n23.12.12.1")
      iam_organisation.save.should == false
      iam_organisation.errors_on(:source_ips).should == ["is invalid", "Invalid IPs [\"123@78.89:91\"]"]

      iam_organisation = Factory.build(:iam_organisation, :source_ips => "123.78.89.91\n23.12.12.1")
      iam_organisation.save.should == true
      iam_organisation.errors_on(:source_ips).should == []
    end
    
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_length_of(:org_uuid).is_at_most(32) }
    it { should validate_length_of(:cert_dn).is_at_most(300) }
    it { should validate_length_of(:email_id).is_at_most(255) }

    context "format" do

      context "name, org_uuid, cert_dn" do 
        it "should accept value matching the format" do
          [:name, :org_uuid, :cert_dn].each do |att|
            should allow_value('username').for(att)
            should allow_value('user-name').for(att)
            should allow_value('user.123').for(att)
            should allow_value('user 123').for(att)
          end
        end

        it "should not accept value which does not match the format" do
          [:name, :org_uuid, :cert_dn].each do |att|
            should_not allow_value('user@name').for(att)
            should_not allow_value('user@123*^').for(att)
          end
        end
      end
    end
  end

  context "check_email_addresses" do 
    it "should validate email address" do 
      iam_organisation = Factory.build(:iam_organisation, :email_id => "1234;esesdgs")
      iam_organisation.should_not be_valid
      iam_organisation.errors_on(:email_id).should == ["is invalid"]
      
      iam_organisation = Factory.build(:iam_organisation, :email_id => "foo@ruby.com;bar@ruby.com")
      iam_organisation.should be_valid
      iam_organisation.errors_on(:email_id).should == []
    end
  end

  context "value_of_source_ips" do
    it 'should return an error if source_ips are not valid' do
      iam_organisation = Factory.build(:iam_organisation, :source_ips => '123.78.89.9123.12.12.1', approval_status: 'A')
      iam_organisation.save.should == false
      iam_organisation.errors_on(:source_ips).should == ["Invalid IPs [\"123.78.89.9123.12.12.1\"]"]

      iam_organisation = Factory.build(:iam_organisation, :source_ips => '123:78:89:91 23.12:12::1', approval_status: 'A')
      iam_organisation.save.should == false
      iam_organisation.errors_on(:source_ips).should == ["is invalid", "Invalid IPs [\"123:78:89:91 23.12:12::1\"]"]
    end

    it 'should not return an error if source_ips are valid' do
      iam_organisation = Factory.build(:iam_organisation, :source_ips => "123.78.89.91\r\n23.12.12.1", approval_status: 'A')
      iam_organisation.save.should == true
      iam_organisation.errors_on(:source_ips).should == []
    end
  end

  context 'is_vpn_on?' do
    it 'should return true if on_vpn is Y' do
      iam_organisation = Factory.build(:iam_organisation, :on_vpn => 'Y', :approval_status => 'A')
      iam_organisation.is_vpn_on?.should == true
      iam_organisation.save.should == false
    end

    it 'should return false if on_vpn is N' do
      iam_organisation = Factory.build(:iam_organisation, :on_vpn => 'N', :cert_dn => nil, :approval_status => 'A')
      iam_organisation.is_vpn_on?.should == false
      iam_organisation.save.should == false
    end
  end

  context 'validates_presence_of cert_dn' do
    it 'should return an error if on_vpn is N and cert_dn is nil' do
      iam_organisation = Factory.build(:iam_organisation, :on_vpn => 'N', :cert_dn => nil, :approval_status => 'A')
      iam_organisation.save.should == false
      iam_organisation.errors_on(:cert_dn).should == ["Required when 'Is VPN On?' is not checked."]
    end

    it 'should return an error if on_vpn is Y and cert_dn is not nil' do
      iam_organisation = Factory.build(:iam_organisation, :on_vpn => 'Y', :cert_dn => 'ABCDE', :approval_status => 'A')
      iam_organisation.save.should == false
      iam_organisation.errors_on(:cert_dn).should == ["is not allowed when 'Is VPN On?' is checked"]
    end
  end

  context 'validates_presence_of source_ips' do
    it 'should return an error if on_vpn is N and source_ips is nil' do
      iam_organisation = Factory.build(:iam_organisation, :on_vpn => 'N', :source_ips => nil, :approval_status => 'A')
      iam_organisation.save.should == false
      iam_organisation.errors_on(:source_ips).should == ["Required when 'Is VPN On?' is not checked."]
    end

    it 'should not return an error if on_vpn is Y and source_ips is not nil' do
      iam_organisation = Factory.build(:iam_organisation, :on_vpn => 'Y', :cert_dn => nil, :source_ips => '123.78.89.91', :approval_status => 'A')
      iam_organisation.save.should == true
      iam_organisation.errors_on(:source_ips).should == []
    end
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      iam_organisation1 = Factory(:iam_organisation, :approval_status => 'A') 
      iam_organisation2 = Factory(:iam_organisation, :name => 'ABC')
      IamOrganisation.all.should == [iam_organisation1]
      iam_organisation2.approval_status = 'A'
      iam_organisation2.save
      IamOrganisation.all.should == [iam_organisation1,iam_organisation2]
    end
  end    

  context "unapproved_records" do 
    it "oncreate: should create unapproved_record if the approval_status is 'U'" do
      iam_organisation = Factory(:iam_organisation)
      iam_organisation.reload
      iam_organisation.unapproved_record_entry.should_not be_nil
    end

    it "oncreate: should not create unapproved_record if the approval_status is 'A'" do
      iam_organisation = Factory(:iam_organisation, :approval_status => 'A')
      iam_organisation.unapproved_record_entry.should be_nil
    end

    it "onupdate: should not remove unapproved_record if approval_status did not change from U to A" do
      iam_organisation = Factory(:iam_organisation)
      iam_organisation.reload
      iam_organisation.unapproved_record_entry.should_not be_nil
      record = iam_organisation.unapproved_record_entry
      # we are editing the U record, before it is approved
      iam_organisation.name = 'Foo123'
      iam_organisation.save
      iam_organisation.reload
      iam_organisation.unapproved_record_entry.should == record
    end

    it "onupdate: should remove unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      iam_organisation = Factory(:iam_organisation)
      iam_organisation.reload
      iam_organisation.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      iam_organisation.approval_status = 'A'
      iam_organisation.save
      iam_organisation.reload
      iam_organisation.unapproved_record_entry.should be_nil
    end

    it "ondestroy: should remove unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      iam_organisation = Factory(:iam_organisation)
      iam_organisation.reload
      iam_organisation.unapproved_record_entry.should_not be_nil
      record = iam_organisation.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      iam_organisation.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      iam_organisation = Factory(:iam_organisation, :approval_status => 'U')
      iam_organisation.approve.save.should == true
      iam_organisation.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      iam_organisation = Factory(:iam_organisation, :approval_status => 'A')
      iam_organisation1 = Factory(:iam_organisation, :approval_status => 'U', :approved_id => iam_organisation.id, :approved_version => 6)
      iam_organisation1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      iam_organisation1 = Factory(:iam_organisation, :approval_status => 'A')
      iam_organisation2 = Factory(:iam_organisation, :approval_status => 'U')
      iam_organisation1.enable_approve_button?.should == false
      iam_organisation2.enable_approve_button?.should == true
    end
  end
end
