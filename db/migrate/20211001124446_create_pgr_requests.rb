class CreatePgrRequests < ActiveRecord::Migration
  def change
    create_table :pgr_requests do |t|

      t.integer :created_by
      t.integer :updated_by
      t.string :table_name
      t.string :to_date

     t.string :approval_status, :limit => 1, :default => 'U'
     t.integer :approved_id
   	 t.integer :approved_version
  	 t.string :last_action,:limit => 1, :default => 'C'
     t.integer :lock_version

     t.timestamps null: false
    end

  end

  unless Group.where(name: "datapurge").first.present?
    data = Group.new
    data.name = "datapurge"
    data.save
  end

  unless Group.where(name: "dashboard").first.present?
    data = Group.new
    data.name = "dashboard"
    data.save
  end

end