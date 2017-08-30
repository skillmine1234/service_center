class AddColumnDecisionByInEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :decision_by, :string, limit: 1, default: 'A', comment: 'the flag which indicates whether the transaction was overriden by human or web service. (A - Auotmatic, H - Human, W - WebService)'
  end
end
