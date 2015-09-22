class AddConstraintsOnEcolCustomers < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute "ALTER TABLE ecol_customers ADD CONSTRAINT constraint_on_cust_alert CHECK (cust_alert_on IN ('A','P','R','N') )"
      execute "ALTER TABLE ecol_customers ADD CONSTRAINT constraint_on_val_method CHECK (val_method IN ('D','W','N') )"
    end
  end

  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute "ALTER TABLE ecol_customers DROP CONSTRAINT constraint_on_cust_alert"
      execute "ALTER TABLE ecol_customers DROP CONSTRAINT constraint_on_val_method"
    end
  end
end
