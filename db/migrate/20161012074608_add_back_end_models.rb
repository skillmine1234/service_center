class AddBackEndModels < ActiveRecord::Migration
  def change
    # only edit/show is allowed
    # data is populated via seeds, and delete is not allowed
    # links to current status (sc_backed_status) and statistics (sc_backend_stats)
    # window_in_mins should be a divisor of 60 , if it is not then the last window of the minute will be of a smaller size
    # validate max_consecutive_failures <= min_consecutive_success <= max_window_failures <= max_window_success (value of 0 is allowed)
    create_table :sc_backends, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 20, :null => false, :comment => "the code for the backend"
      t.string :do_auto_shutdown, :limit => 1, :null => false, :comment => 'the flag that indicates if the backend will be shutdown automatically when thresholds are breached'
      t.integer :max_consecutive_failures, :null => false, :comment => 'the acceptible threshold for consecutive failures'
      t.integer :window_in_mins, :null => false, :limit => 2, :comment => 'the window size in mins (min 1, max 60)'
      t.integer :max_window_failures, :null => false, :comment => 'the acceptible threshold for failures in a window'
      t.string :do_auto_start, :limit => 1, :null => false, :comment => 'the flag that indicates if the backend will be started automatically when thresholds are met'
      t.integer :min_consecutive_success, :null => false, :comment => 'the min no of successful replies to start the backend'
      t.integer :min_window_success, :null => false, :comment => 'the min no of succesful replies in a window to start the backend'
      t.string :alert_email_to, :comment => 'a comma separated list of email address to which email alerts are to be sent'

      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"

      t.index([:code], :unique => true, :name => "sc_backends_01")      
    end

    # to record every status change, status changes do not require a maker/checker (approval)
    # a status change requires the new status to be different than the current status
    # status changes can be done by humans or by the system
    # create is required
    create_table :sc_backend_status_changes, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 20, :null => false, :comment => "the code for the backend"
      t.string :new_status, :limit => 1, :null => false, :comment => 'the new status for the backend'
      t.string :remarks, :null => false, :comment => 'the reason for the status change'

      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
    end

    # updated when a new status change is created (see above) by a human or automatically by the system
    # show page, with the index of :sc_backend_status_changes is required
    create_table :sc_backend_status, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 20, :null => false, :comment => "the code for the backend"
      t.string :status, :limit => 1, :null => false, :comment => 'the current status for the backend'
      t.integer :last_status_change_id, :comment => 'the foriegn key to the sc_backend_status_changes' 
      
      t.index([:last_status_change_id], :name => "sc_backend_status_1")      
      t.index([:code], :unique => true, :name => "sc_backend_status_2")
    end

    # records statistics for the backend
    # only show
    create_table :sc_backend_stats, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 20, :null => false, :comment => "the code for the backend"
      
      t.integer :consecutive_failure_cnt, :null => false, :comment => 'the current count of consecutive failures'
      t.integer :consecutive_success_cnt, :null => false, :comment => 'the current count of consecutive success replies'

      t.datetime :window_started_at, :null => false, :comment => "the timestamp when the window started"
      t.datetime :window_ends_at, :null => false, :comment => "the timestamp when the window ends"
      t.integer :window_failure_cnt, :null => false, :comment => 'the current count of failures in the current window'
      t.integer :window_success_cnt, :null => false, :comment => 'the current count of success replies in the current window'

      t.string :auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this record"
      t.string :step_name, :limit => 100, :null => true, :comment => 'the (optional) english name of the step of the request that is related to this record'

      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      
      t.integer :last_status_change_id, :comment => 'the foriegn key to the sc_backend_status_changes, when the status was changed automatically' 
      t.datetime :last_alert_email_at, :comment => "the timestamp when an email alert was last sent"
      t.string :last_alert_email_ref, :limit => 64, :comment => "the ref for the last email alert"
      
      t.index([:code], :unique => true, :name => "sc_backend_stats_1")
    end
    
  end
end
