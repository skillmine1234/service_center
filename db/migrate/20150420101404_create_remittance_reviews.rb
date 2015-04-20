class CreateRemittanceReviews < ActiveRecord::Migration
  def change
    create_table :remittance_reviews do |t|
      t.string :transaction_id, :limit => 5, :null => false
      t.string :justification_code, :limit => 5, :null => false
      t.string :justification_text, :limit => 2000
      t.string :review_status, :limit => 10, :null => false
      t.date :reviewed_at
      t.string :review_remarks, :limit => 2000
      t.string :reviewed_by, :limit => 50
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.integer :lock_version

      t.timestamps
    end
  end
end
