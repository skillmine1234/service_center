require 'spec_helper'

describe FpOperation do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context "validations" do
    it { should validate_presence_of(:operation_name)}
    
    it do
      fp_operation = Factory(:fp_operation, :operation_name => 'App10', :approval_status => 'A')
      should validate_uniqueness_of(:operation_name).scoped_to(:approval_status)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      fp_operation1 = Factory(:fp_operation, :approval_status => 'A') 
      fp_operation2 = Factory(:fp_operation, :operation_name => "qweas")
      FpOperation.all.should == [fp_operation1]
      fp_operation2.approval_status = 'A'
      fp_operation2.save
      FpOperation.all.should == [fp_operation1,fp_operation2]
    end
  end    

  context "fp_unapproved_records" do 
    it "oncreate: should create fp_unapproved_record if the approval_status is 'U'" do
      fp_operation = Factory(:fp_operation)
      fp_operation.reload
      fp_operation.fp_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create fp_unapproved_record if the approval_status is 'A'" do
      fp_operation = Factory(:fp_operation, :approval_status => 'A')
      fp_operation.fp_unapproved_record.should be_nil
    end

    it "onupdate: should not remove fp_unapproved_record if approval_status did not change from U to A" do
      fp_operation = Factory(:fp_operation)
      fp_operation.reload
      fp_operation.fp_unapproved_record.should_not be_nil
      record = fp_operation.fp_unapproved_record
      # we are editing the U record, before it is approved
      fp_operation.operation_name = 'Fooo'
      fp_operation.save
      fp_operation.reload
      fp_operation.fp_unapproved_record.should == record
    end
    
    it "onupdate: should remove fp_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      fp_operation = Factory(:fp_operation)
      fp_operation.reload
      fp_operation.fp_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      fp_operation.approval_status = 'A'
      fp_operation.save
      fp_operation.reload
      fp_operation.fp_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove fp_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      fp_operation = Factory(:fp_operation)
      fp_operation.reload
      fp_operation.fp_unapproved_record.should_not be_nil
      record = fp_operation.fp_unapproved_record
      # the approval process destroys the U record, for an edited record 
      fp_operation.destroy
      PcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      fp_operation = Factory(:fp_operation, :approval_status => 'U')
      fp_operation.approve.should == ""
      fp_operation.approval_status.should == 'A'
    end

    it "should return error when trying to edit approved_record" do 
      fp_operation = Factory(:fp_operation, :approval_status => 'A')
      fp_operation2 = Factory.build(:fp_operation, :approval_status => 'U', :approved_id => fp_operation.id, :approved_version => 6)
      fp_operation2.save.should == false
      fp_operation2.errors[:base].should == ["You cannot edit this record as it is already approved!"]
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      fp_operation1 = Factory(:fp_operation, :approval_status => 'A')
      fp_operation2 = Factory(:fp_operation, :operation_name => "qweas", :approval_status => 'U')
      fp_operation1.enable_approve_button?.should == false
      fp_operation2.enable_approve_button?.should == true
    end
  end
end
