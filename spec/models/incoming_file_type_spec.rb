require 'spec_helper'

describe IncomingFileType do
  context 'validation' do
    [:sc_service_id, :code, :name].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      Factory(:incoming_file_type)
      should validate_uniqueness_of(:sc_service_id) 
      should validate_uniqueness_of(:name) 
      should validate_uniqueness_of(:code) 
    end
  end
end
