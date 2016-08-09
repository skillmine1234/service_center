require 'spec_helper'

describe PurposeCode do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:inw_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:code, :description, :is_enabled, :txn_limit].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      purpose_code = Factory(:purpose_code) 
      should validate_uniqueness_of(:code).scoped_to(:approval_status)
    end
    
    [:code].each do |att|
      it { should validate_length_of(att).is_at_least(4) }
      it { should validate_length_of(att).is_at_most(4) }
    end

    [:rbi_code].each do |att|
      it { should validate_length_of(att).is_at_least(5) }
      it { should validate_length_of(att).is_at_most(5) }
    end
    
    it "should validate_unapproved_record" do 
      purpose_code1 = Factory(:purpose_code,:approval_status => 'A')
      purpose_code2 = Factory(:purpose_code, :approved_id => purpose_code1.id)
      purpose_code1.should_not be_valid
      purpose_code1.errors_on(:base).should == ["Unapproved Record Already Exists for this record"]
    end

    context "code format" do
      it "should allow valid format" do 
        [:code].each do |att|
          should allow_value('ab1V').for(att)
          should allow_value('acde').for(att)
          should allow_value('1343').for(att)
          should allow_value('aBCD').for(att)
        end

        [:rbi_code].each do |att|
          should allow_value('ab1Vi').for(att)
          should allow_value('acde0').for(att)
          should allow_value('13439').for(att)
          should allow_value('aBCDk').for(att)
        end
      end

      it "should not allow invalid format" do 
        [:code].each do |att|
          should_not allow_value('a 1V').for(att)
          should_not allow_value('@acd').for(att)
          should_not allow_value('134\n').for(att)
        end

        [:rbi_code].each do |att|
          should_not allow_value('va 1V').for(att)
          should_not allow_value('b@acd').for(att)
          should_not allow_value('8134\n').for(att)
        end
      end
    end

    context "values" do 
      it "should accept following values" do
        [:mtd_txn_limit_self, :mtd_txn_limit_sp].each do |att|
          should allow_value(0).for(att)
          should allow_value('9e20'.to_f).for(att)
        end
        [:txn_limit, :mtd_txn_cnt_self, :mtd_txn_cnt_sp].each do |att|
          should allow_value(0).for(att)
          should allow_value('9e20'.to_f).for(att)
        end
      end

      it "should not accept following values" do
        [:mtd_txn_limit_self, :mtd_txn_limit_sp].each do |att|
          should_not allow_value(-1).for(att)
          should_not allow_value('9e21'.to_f).for(att)
        end
        [:txn_limit, :mtd_txn_cnt_self, :mtd_txn_cnt_sp].each do |att|
          should_not allow_value(-1).for(att)
          should_not allow_value('9e21'.to_f).for(att)
        end
      end
    end

    context "check_values" do 
      it "should validate mtd_txn_limit_self" do 
        purpose_code = Factory.build(:purpose_code, :mtd_txn_limit_self => 1000, :txn_limit => 1200)
        purpose_code.should_not be_valid
        purpose_code.errors_on("mtd_txn_limit_self").should == ["is less than transaction limit"]
      end

      it "should validate mtd_txn_limit_sp" do 
        purpose_code = Factory.build(:purpose_code, :mtd_txn_limit_sp => 1000, :txn_limit => 1200)
        purpose_code.should_not be_valid
        purpose_code.errors_on("mtd_txn_limit_sp").should == ["is less than transaction limit"]
      end
    end

    context "validate_keywords" do 
      it "should validate keywords in beneficiaries and remitters" do 
        purpose_code = Factory.build(:purpose_code, :pattern_beneficiaries => "1234 ese@sdgs", :pattern_remitters => "1234 ese@sdgs")
        purpose_code.should_not be_valid
        purpose_code.errors_on("pattern_beneficiaries").should == ["is invalid"]
        purpose_code.errors_on("pattern_remitters").should == ["is invalid"]
        purpose_code = Factory.build(:purpose_code, :pattern_beneficiaries => "1234 esesdgs", :pattern_remitters => "1234 esesdgs")
        purpose_code.should be_valid
        purpose_code = Factory.build(:purpose_code, :pattern_beneficiaries => "  ", :pattern_remitters => "  ")
        purpose_code.should be_valid
        purpose_code.pattern_beneficiaries.should == ""
        purpose_code.pattern_remitters.should == ""
      end
    end
  end
  
  context 'disallowed_rem_and_bene_types_to_string'do
    it 'should be a string' do
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string(["I","C"]).should == "I,C"
      purpose_code.convert_disallowed_bene_types_to_string(["I","C"]).should == "I,C"
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string(["I"]).should == "I"
      purpose_code.convert_disallowed_bene_types_to_string(["C"]).should == "C"
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string([]).should == ""
      purpose_code.convert_disallowed_bene_types_to_string([]).should == ""
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string("I").should == ""
      purpose_code.convert_disallowed_bene_types_to_string("C").should == ""
      
    end
  end   
  
  context "options_for_bene_and_rem_types" do
    it "should return options for disallowed remitter and beneficiary types" do
      PurposeCode.options_for_bene_and_rem_types.should == [['Individual','I'],['Corporates','C']]
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      purpose_code1 = Factory(:purpose_code, :approval_status => 'A') 
      purpose_code2 = Factory(:purpose_code, :code => "0002")
      PurposeCode.all.should == [purpose_code1]
      purpose_code2.approval_status = 'A'
      purpose_code2.save
      PurposeCode.all.should == [purpose_code1, purpose_code2]
    end
  end    

  context "inw_unapproved_records" do 
    it "oncreate: should create inw_unapproved_record if the approval_status is 'U'" do
      purpose_code = Factory(:purpose_code)
      purpose_code.reload
      purpose_code.inw_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create inw_unapproved_record if the approval_status is 'A'" do
      purpose_code = Factory(:purpose_code, :approval_status => 'A')
      purpose_code.inw_unapproved_record.should be_nil
    end

    it "onupdate: should not remove inw_unapproved_record if approval_status did not change from U to A" do
      purpose_code = Factory(:purpose_code)
      purpose_code.reload
      purpose_code.inw_unapproved_record.should_not be_nil
      record = purpose_code.inw_unapproved_record
      # we are editing the U record, before it is approved
      purpose_code.description = 'Fooo'
      purpose_code.save
      purpose_code.reload
      purpose_code.inw_unapproved_record.should == record
    end
    
    it "onupdate: should remove inw_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      purpose_code = Factory(:purpose_code)
      purpose_code.reload
      purpose_code.inw_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      purpose_code.approval_status = 'A'
      purpose_code.save
      purpose_code.reload
      purpose_code.inw_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove inw_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      purpose_code = Factory(:purpose_code)
      purpose_code.reload
      purpose_code.inw_unapproved_record.should_not be_nil
      record = purpose_code.inw_unapproved_record
      # the approval process destroys the U record, for an edited record 
      purpose_code.destroy
      InwUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      purpose_code = Factory(:purpose_code, :approval_status => 'U')
      purpose_code.approve.should == ""
      purpose_code.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      purpose_code = Factory(:purpose_code, :approval_status => 'A')
      purpose_code2 = Factory(:purpose_code, :approval_status => 'U', :approved_id => purpose_code.id, :approved_version => 6)
      purpose_code2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      purpose_code1 = Factory(:purpose_code, :approval_status => 'A')
      purpose_code2 = Factory(:purpose_code, :approval_status => 'U')
      purpose_code1.enable_approve_button?.should == false
      purpose_code2.enable_approve_button?.should == true
    end
  end
  
end