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
end