class CreateScJobs < ActiveRecord::Migration
  def change
    create_table :sc_jobs, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :code, :limit => 100, :null => false, :comment => "the code for this job"
      t.integer :sc_service_id, :null => false, :comment => "the id of the service to which this job belongs to"
      t.integer :run_at_hour, :comment => "the hour at which this job has to run"
      t.datetime :last_run_at, :comment => "the time at which this job was last run"
      t.string :last_run_by, :limit => 100, :comment => "the uuid of integration node who ran this job last"
      t.string :run_now, :limit => 1, :comment => "the flag to indicate whether this job can be run now"
      t.string :paused, :limit => 1, :comment => "the flag to indicate whether to pause the job"
      t.index([:code, :sc_service_id], :unique => true, :name => "sc_jobs_01")
    end
  end
end
