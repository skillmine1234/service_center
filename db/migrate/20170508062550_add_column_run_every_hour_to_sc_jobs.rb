class AddColumnRunEveryHourToScJobs < ActiveRecord::Migration
  def change
    add_column :sc_jobs, :run_every_hour, :number, :comment => "the running hours frequency to schedule the report"
  end
end
