require 'spec_helper'

describe PurposeCode do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :description, :is_enabled, :txn_limit, :daily_txn_limit, :mtd_txn_cnt_self, :rbi_code].each do |att|
      it { should validate_presence_of(att) }
    end

    [:code].each do |att|
      it { should validate_uniqueness_of(att) }
    end
    [:code,:rbi_code].each do |att|
      it { should validate_length_of(att).is_at_least(5) }
      it { should validate_length_of(att).is_at_most(5) }
    end

    context "code format" do
      it "should allow valid format" do 
        [:code,:rbi_code].each do |att|
          should allow_value('abc1V').for(att)
          should allow_value('abcde').for(att)
          should allow_value('12343').for(att)
          should allow_value('aABCD').for(att)
        end
      end

      it "should not allow invalid format" do 
        [:code,:rbi_code].each do |att|
          should_not allow_value('abc 1V').for(att)
          should_not allow_value('@abcd').for(att)
          should_not allow_value('1234\n').for(att)
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