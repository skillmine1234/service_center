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
    # it do
    #   bank = Factory(:bank)
    #   should validate_uniqueness_of(:ifsc)
    # end

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

    context "name format" do
      it "should allow valid format" do 
        [:name].each do |att|
          should allow_value('abcddfgdfg').for(att)
          should allow_value('aBCDdfdsgs').for(att)
        end
      end

      it "should not allow invalid format" do 
        [:name].each do |att|
          should_not allow_value('ab*dsgdsgf').for(att)
          should_not allow_value('a12232424V').for(att)
          should_not allow_value('@acddsfdfd').for(att)
          should_not allow_value('134\ndsfdsg').for(att)
        end
      end
    end

    context "imps_enabled?" do 
      it "should return 'Y' if imps_enabled is true and 'N' if false" do 
        bank = Factory(:bank, :imps_enabled => 1)
        bank.imps_enabled?.should == 'Y'
        bank = Factory(:bank, :imps_enabled => 0)
        bank.imps_enabled?.should == 'N'
      end
    end
  end
end
