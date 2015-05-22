require 'spec_helper'

describe Bank do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:ifsc, :name].each do |att|
      it { should validate_presence_of(att) }
    end

    # it {should validate_inclusion_of(:imps_enabled).in_array([true,false]) }

    context "ifsc format" do 
      it "should validate the format of ifsc" do 
        bank = Factory.build(:bank, :ifsc => 'ABcd0dsg34A')
        bank.should be_valid
        bank = Factory.build(:bank, :ifsc => 'ABcd0dsg34')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABcd4dsg34A')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABcd0dsg34$')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABc@0dsg34A')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABc@@dsg34A')
        bank.should_not be_valid
      end
    end
  end
end
