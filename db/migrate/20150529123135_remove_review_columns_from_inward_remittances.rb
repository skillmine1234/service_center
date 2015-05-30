class RemoveReviewColumnsFromInwardRemittances < ActiveRecord::Migration
  def change
    remove_column :inward_remittances, :bene_ref
    remove_column :inward_remittances, :review_reqd
    remove_column :inward_remittances, :review_pending
  end
end
