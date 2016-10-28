require 'spec_helper'

describe ScBackendStatusChange do
  context 'association' do
    it { should belong_to(:sc_backend) }
  end

  context 'validation' do
    [:code, :new_status, :remarks].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      sc_backend_status = Factory(:sc_backend_status_change)
      should validate_length_of(:code).is_at_most(20)
      should validate_length_of(:new_status).is_at_least(1).is_at_most(1)
    end
  end
end
