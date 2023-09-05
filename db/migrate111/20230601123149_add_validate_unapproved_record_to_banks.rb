class AddValidateUnapprovedRecordToBanks < ActiveRecord::Migration[7.0]
  def change
    add_column :banks, :validate_unapproved_record, :string
  end
end
