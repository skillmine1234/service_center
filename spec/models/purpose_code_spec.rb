require 'spec_helper'
include PurposeCodeHelper

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
   
  context 'disallowed_rem_and_bene_types_to_array'do
    it 'should be an array' do
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "I,N", :disallowed_bene_types => "I,N" )
      convert_options_to_array("I,N").should == ["I","N"]
      convert_options_to_array("I,N").should == ["I","N"]
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "I", :disallowed_bene_types => "N" )
      convert_options_to_array("I").should == ["I"]
      convert_options_to_array("N").should == ["N"]
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "I", :disallowed_bene_types => "" )
      convert_options_to_array("I").should == ["I"]
      convert_options_to_array("").should == []
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "", :disallowed_bene_types => "" )
      convert_options_to_array("").should == []
      convert_options_to_array("").should == []
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => nil, :disallowed_bene_types => nil)
      convert_options_to_array(nil).should == []
      convert_options_to_array(nil).should == []
    end
  end 
  
  context 'disallowed_rem_and_bene_types_values_on_show_page'do    
    it 'should show values on show page' do
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "I,N")
      disallowed_bene_and_rem_types_on_show_page("I,N").should == "Individual,Non-Individual"
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "I")
      disallowed_bene_and_rem_types_on_show_page("I").should == "Individual"
      purpose_code= Factory.build(:purpose_code, :disallowed_rem_types => "N")
      disallowed_bene_and_rem_types_on_show_page("N").should == "Non-Individual"
    end
  end
    
end