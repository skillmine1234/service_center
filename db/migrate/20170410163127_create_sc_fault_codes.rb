class CreateScFaultCodes < ActiveRecord::Migration
  def change
    create_table :sc_fault_codes, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :fault_code, limit: 50, null: false, comment: 'the fault code returned for by a service'
      t.string :fault_reason, limit: 1000, null: false, comment: 'the english text returned along with the fault code'
      t.string :fault_kind, limit: 1, null: false, comment: 'the indicator that classifies the fault - B for business,  T for techincal, S for setup/configuration'
      t.string :occurs_when, limit: 1000, null: false, comment: 'the underlying cause that results in the fault'
      t.string :remedial_action, limit: 1000, null: false, comment: 'the suggested remedial action to be taken when the fault occurs'
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
    end
  end
end
