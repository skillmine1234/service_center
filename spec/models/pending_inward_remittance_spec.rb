require 'spec_helper'

describe PendingInwardRemittance do

  context 'validation' do
    [:inward_remittance_id, :broker_uuid].each do |att|
      it { should validate_presence_of(att) }
    end
  end

end
