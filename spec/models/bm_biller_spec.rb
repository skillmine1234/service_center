require 'spec_helper'

describe BmBiller do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:bm_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:biller_code, :biller_name, :biller_category, :biller_location, :processing_method, :is_enabled, :num_params].each do |att|
      it { should validate_presence_of(att) }
    end 
    
    it do 
      bm_biller = Factory(:bm_biller, :approval_status => 'A')
      should validate_uniqueness_of(:biller_code).scoped_to(:approval_status)   
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      bm_biller1 = Factory(:bm_biller, :approval_status => 'A') 
      bm_biller2 = Factory(:bm_biller, :biller_code => '12we')
      BmBiller.all.should == [bm_biller1]
      bm_biller2.approval_status = 'A'
      bm_biller2.save
      BmBiller.all.should == [bm_biller1,bm_biller2]
    end
  end    

  context "create_bm_unapproved_records" do 
    it "should create bm_unapproved_record if the approval_status is 'U' and there is no previous record" do
      bm_biller = Factory(:bm_biller)
      bm_biller.reload
      bm_biller.bm_unapproved_record.should_not be_nil
      record = bm_biller.bm_unapproved_record
      bm_biller.biller_name = 'Foo'
      bm_biller.save
      bm_biller.bm_unapproved_record.should == record
    end

    it "should not create bm_unapproved_record if the approval_status is 'A'" do
      bm_biller = Factory(:bm_biller, :approval_status => 'A')
      bm_biller.bm_unapproved_record.should be_nil
    end
  end  

  context "remove_bm_unapproved_records" do 
    it "should remove bm_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
      bm_biller = Factory(:bm_biller)
      bm_biller.reload
      bm_biller.bm_unapproved_record.should_not be_nil
      record = bm_biller.bm_unapproved_record
      bm_biller.biller_name = 'Foo'
      bm_biller.save
      bm_biller.bm_unapproved_record.should == record
      bm_biller.approval_status = 'A'
      bm_biller.save
      bm_biller.remove_bm_unapproved_records
      bm_biller.reload
      bm_biller.bm_unapproved_record.should be_nil
    end
  end  

  context "approve" do 
    it "should approve unapproved_record" do 
      bm_biller = Factory(:bm_biller, :approval_status => 'U')
      bm_biller.approve.should == ""
      bm_biller.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      bm_biller = Factory(:bm_biller, :approval_status => 'A')
      bm_biller1 = Factory(:bm_biller, :approval_status => 'U', :approved_id => bm_biller.id, :approved_version => 6)
      bm_biller1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      bm_biller1 = Factory(:bm_biller, :approval_status => 'A')
      bm_biller2 = Factory(:bm_biller, :approval_status => 'U')
      bm_biller1.enable_approve_button?.should == false
      bm_biller2.enable_approve_button?.should == true
    end
  end
end