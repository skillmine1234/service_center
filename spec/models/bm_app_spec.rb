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
  end
end