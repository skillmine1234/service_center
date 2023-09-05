class AddGuidelineIdToPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :purpose_codes, :guideline_id, :integer, null: false, default: 1, comment: 'the guidline for which this purpose code is allowed'
  end
end
