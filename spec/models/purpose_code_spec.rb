require 'spec_helper'

describe PurposeCode do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :description, :is_enabled, :txn_limit, :daily_txn_limit].each do |att|
      it { should validate_presence_of(att) }
    end

    [:code].each do |att|
      it { should validate_uniqueness_of(att) }
    end
  end
  
  context 'disallowed_rem_and_bene_types_to_string'do
    it 'should be a string' do
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string(["I","N"]).should == "I,N"
      purpose_code.convert_disallowed_bene_types_to_string(["I","N"]).should == "I,N"
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string(["I"]).should == "I"
      purpose_code.convert_disallowed_bene_types_to_string(["N"]).should == "N"
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string([]).should == ""
      purpose_code.convert_disallowed_bene_types_to_string([]).should == ""
      purpose_code= Factory.build(:purpose_code)
      purpose_code.convert_disallowed_rem_types_to_string("I").should == ""
      purpose_code.convert_disallowed_bene_types_to_string("N").should == ""
      
    end
  end    
end