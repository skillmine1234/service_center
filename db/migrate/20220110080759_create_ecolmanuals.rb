class CreateEcolmanuals < ActiveRecord::Migration
  def change
    create_table :ecolmanual_files do |t|
      t.string :file_name
      t.string :file
      t.text :updated_by
      t.string :created_by

      t.string :approval_status , :limit => 1, :default => 'U', :null => false
      t.string :last_action, :limit => 1, :default => 'C'
      t.integer :approved_version
      t.integer :approved_id
      t.integer :lock_version

      t.timestamps null: false
    end
  end
end


unless Group.where(name: "ecolmanual").first.present?
    data = Group.new
    data.name = "ecolmanual"
    data.save
  end
