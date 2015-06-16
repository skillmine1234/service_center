require 'spec_helper'

describe UdfAttribute do
  context 'validation' do
    [:class_name, :attribute_name, :is_enabled].each do |att|
      it { should validate_presence_of(att) }
    end

    context "validate_data_type" do 
      it "should return error if the data type is not present when the control type is TextBox" do 
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => nil)
        udf.should_not be_valid
        udf.errors_on(:data_type).should == ["should be present for TextBox control"]
        udf = Factory.build(:udf_attribute, :control_type => 'CheckBox', :data_type => nil)
        udf.should be_valid
        udf.errors_on(:data_type).should == []
      end
    end

    context "validate_options" do
      it "should return error in case of invalid format for options" do
        udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :select_options => "---\n name1: value1\n\r name2:value2")
        udf.should_not be_valid
        udf.errors_on(:select_options).should == ["not in the following format <br> \"name1\": \"value1\" <br> \"name2\": \"value2\" <br>"]
        udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :select_options => "---\n name1: value1")
        udf.should_not be_valid
        udf.errors_on(:select_options).should == ["not in the following format <br> \"name1\": \"value1\" <br> \"name2\": \"value2\" <br>"]
        udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :select_options => "\"name1\": \"value1\"\r\n\"name2\": \"value2\"")
        udf.should be_valid
      end
    end

    context "validate_constraint_input" do
      it "should retrn error in case all length and min_length and max_length are specified for string data type" do
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String', :length => 3, :min_length => 4, :max_length => 5)
        udf.should_not be_valid
        udf.errors_on(:data_type).should == ["Please specify Either Length or (min Length and max Length) for this data type"]
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String', :length => 3, :min_length => 4, :max_length => "")
        udf.should_not be_valid
        udf.errors_on(:data_type).should == ["Please specify Either Length or (min Length and max Length) for this data type"]
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String', :length => 3, :min_length => "", :max_length => "")
        udf.should be_valid
        udf.errors_on(:data_type).should == []
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String', :length => "", :min_length => 4, :max_length => "")
        udf.should be_valid
        udf.errors_on(:data_type).should == []
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String', :length => "", :min_length => 4, :max_length => 5)
        udf.should be_valid
        udf.errors_on(:data_type).should == []
        udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String', :length => "", :min_length => "", :max_length => 5)
        udf.should be_valid
        udf.errors_on(:data_type).should == []
      end
    end
  end

  context "type" do
    it "should return the type as boolean if control type is checkbox" do
      udf = Factory.build(:udf_attribute, :control_type => 'CheckBox')
      udf.type.should == "boolean"
    end

    it "should return the type as select if control type is dropdown" do
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown')
      udf.type.should == "select"
    end

    it "should return the type as date if data type is Date" do
      udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'Date')
      udf.type.should == "date"
    end

    it "should return the type as select if control type is dropdown" do
      udf = Factory.build(:udf_attribute, :control_type => 'TextBox', :data_type => 'String')
      udf.type.should == "string"
    end
  end

  context "regenerate_accessor_fields" do
    it "should return value for the symbol in hash" do
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :constraints => {:min_length => {:minimum => 6}})
      udf.regenerate_accessor_fields
      udf.min_length.should == 6
    end
  end

  context "construct_validate_hash" do
    it "should construct hash before save" do
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :constraints => {}, :min_length => 6)
      udf.construct_validate_hash
      udf.constraints.should == {:min_length => {:minimum => 6}}
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :constraints => {}, :length => 6)
      udf.construct_validate_hash
      udf.constraints.should == {:length => {:is => 6, :message => "should be of 6 characters"}}
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :constraints => {}, :max_length => 6)
      udf.construct_validate_hash
      udf.constraints.should == {:max_length => {:maximum => 6}}
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :constraints => {}, :min_value => 6)
      udf.construct_validate_hash
      udf.constraints.should == {:min_value => {:minimum => 6}}
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :constraints => {}, :max_value => 6)
      udf.construct_validate_hash
      udf.constraints.should == {:max_value => {:maximum => 6}}
    end
  end
  
  context "options_list" do 
    it "should return options in a hash" do 
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :select_options => "---\n name1: value1")
      udf.select_options_list.should == {"name1" => "value1"}
      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :select_options => nil)
      udf.select_options_list.should be_nil
    end
  end
  
  context "cross_field_validations" do
    it "should perform cross field validations" do
      udf = Factory.build(:udf_attribute, :is_enabled => 'Y', :label_text => nil, :control_type => nil)
      udf.save == false
      udf.errors_on(:is_enabled).should == ['Label_text and control_type fields are mandatory if is_enabled is Y']

      udf = Factory.build(:udf_attribute, :control_type => 'DropDown', :max_length => 1, :min_length => 1)
      udf.save == false
      udf.errors_on(:control_type).should == ['Constraints cannot be entered if control_type is Dropdown']      
    end
  end
  
  context "options_for_attribute_name" do
    it  "should return options for attribute name" do
      UdfAttribute.options_for_attribute_name.should ==  [['udf1','udf1'],['udf2','udf2'],['udf3','udf3'],['udf4','udf4'],
      ['udf5','udf5'],['udf6','udf6'],['udf7','udf7'],['udf8','udf8'],['udf9','udf9'],['udf10','udf10'],
      ['udf11','udf11'],['udf12','udf12'],['udf13','udf13'],['udf14','udf14'],['udf15','udf15'],['udf16','udf16'],
      ['udf17','udf17'],['udf18','udf18'],['udf19','udf19'],['udf20','udf20']]   
    end
  end
  
end