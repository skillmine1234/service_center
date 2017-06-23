# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :imt_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'TXNS',:service_name => 'IMTSERVICE')).id}
    sequence(:file_name) {|n| "file#{n}"} 
    sequence(:record_no) {|n| "{n}"}
    issuing_bank 'ABC BANK'
    acquiring_bank 'XYZ BANK'
    sequence(:imt_ref_no) {|n| "IMTREF#{n}"} 
    txn_issue_date '2017-05-05 10:04:40'
    txn_acquire_date '2017-05-06 10:04:40'
    sequence(:issuing_bank_txn_id) {|n| "TXN#{n}"} 
    crdr 'Y'
    transfer_amount '12.2'
    acquiring_fee '1111.2'
    sc_on_acquiring_fee '1111.3'
    npci_charges '1111.4'
    sc_on_npci_charges '1111.5'
    total_net_position '1111.6'
  end
end
