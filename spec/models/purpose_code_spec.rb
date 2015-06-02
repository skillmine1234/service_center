require 'spec_helper'

describe PurposeCode do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :description, :is_enabled, :txn_limit].each do |att|
      it { should validate_presence_of(att) }
    end

    [:code].each do |att|
      it { should validate_uniqueness_of(att) }
    end
    [:code].each do |att|
      it { should validate_length_of(att).is_at_least(4) }
      it { should validate_length_of(att).is_at_most(4) }
    end

    [:rbi_code].each do |att|
      it { should validate_length_of(att).is_at_least(5) }
      it { should validate_length_of(att).is_at_most(5) }
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

    context "formated_pattern_beneficiaries" do 
      it "should format pattern_beneficiaries" do 
        purpose_code = Factory.build(:purpose_code, :pattern_beneficiaries => "1,2")
        purpose_code.formated_pattern_beneficiaries.should == "1\r\n2"
      end 
    end

    context "validate_keywords" do 
      it "should validate keywords" do 
        purpose_code = Factory.build(:purpose_code, :pattern_beneficiaries => "1234,ese@sdgs")
        purpose_code.should_not be_valid
        purpose_code.errors_on("pattern_beneficiaries").should == ["are invalid due to ese@sdgs"]
        purpose_code = Factory.build(:purpose_code, :pattern_beneficiaries => "1234,esesdgs")
        purpose_code.should be_valid
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
end