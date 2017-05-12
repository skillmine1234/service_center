require 'spec_helper'

describe BmApp do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:bm_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:app_id, :channel_id].each do |att|
      it { should validate_presence_of(att) }
    end 
    
    it do 
      bm_app = Factory(:bm_app, :approval_status => 'A')
      should validate_uniqueness_of(:app_id).scoped_to(:approval_status)   
    end

    it 'should show an error for flex_user_id, if is_configuration_global is "N" and flex_user_id is nil' do
      bm_app = Factory.build(:bm_app, :approval_status => 'A', :is_configuration_global => 'N', :flex_user_id => nil)
      bm_app.save.should == false
      bm_app.errors_on(:flex_user_id).should == ["can't be blank"]
    end

    it 'should not show an error on flex_user_id, if is_configuration_global is "N" and flex_user_id is present' do
      bm_app = Factory.build(:bm_app, :approval_status => 'A', :is_configuration_global => 'N', :flex_user_id => 'abcd')
      bm_app.save.should == false
      bm_app.errors_on(:flex_user_id).should == []
    end

    it 'should show an error on flex_narrative_prefix, if is_configuration_global is "N" and flex_narrative_prefix is nil' do
      bm_app = Factory.build(:bm_app, :approval_status => 'A', :is_configuration_global => 'N', :flex_narrative_prefix => nil)
      bm_app.save.should == false
      bm_app.errors_on(:flex_narrative_prefix).should == ["can't be blank"]
    end

    it 'should not show an error on flex_narrative_prefix, if is_configuration_global is "N" and flex_narrative_prefix is present' do
      bm_app = Factory.build(:bm_app, :approval_status => 'A', :is_configuration_global => 'N', :flex_narrative_prefix => 'abcd')
      bm_app.save.should == false
      bm_app.errors_on(:flex_narrative_prefix).should == []
    end

    it 'should not show an error if is_configuration_global is "Y" and flex_user_id is nil' do
      bm_app = Factory.build(:bm_app, :approval_status => 'A', :is_configuration_global => 'Y', :flex_user_id => nil)
      bm_app.save.should == true
      bm_app.errors_on(:flex_user_id).should == []
    end

    it 'should not show an error if is_configuration_global is "Y" and flex_narrative_prefix is nil' do
      bm_app = Factory.build(:bm_app, :approval_status => 'A', :is_configuration_global => 'Y', :flex_narrative_prefix => nil)
      bm_app.save.should == true
      bm_app.errors_on(:flex_narrative_prefix).should == []
    end
  end
end