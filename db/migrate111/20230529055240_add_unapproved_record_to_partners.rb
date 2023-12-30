class AddUnapprovedRecordToPartners < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :unapproved_record, :string
  end
end
