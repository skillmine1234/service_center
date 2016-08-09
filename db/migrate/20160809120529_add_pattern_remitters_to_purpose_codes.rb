class AddPatternRemittersToPurposeCodes < ActiveRecord::Migration
  def self.up
    add_column :purpose_codes, :pattern_remitters, :string, :limit => 4000, :comment => "the keywords that are allowed in remitters name"
  end

  def self.down
    remove_column :purpose_codes, :pattern_remitters, :string
  end
end
