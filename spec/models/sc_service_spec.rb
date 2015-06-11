require 'spec_helper'

describe ScService do
  context 'validation' do
    [:code, :name].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      sc_service = Factory(:sc_service)
      should validate_uniqueness_of(:name) 
      should validate_uniqueness_of(:code) 
    end
  end
end
