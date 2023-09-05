class AddValidateUnapprovedRecordToPartners < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :validate_unapproved_record, :string
  end
end
