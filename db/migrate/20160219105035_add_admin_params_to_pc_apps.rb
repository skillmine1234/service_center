class AddAdminParamsToPcApps < ActiveRecord::Migration
  def change
    columns = [ {"table" => "pc_apps", 
                 "column" => "mm_admin_host", 
                 "comment" => "the MatchMove Admin host URI"}, 
                 
                 {"table" => "pc_apps", 
                  "column" => "mm_admin_user", 
                  "comment" => "the username for basic authentication with admin host"},
                
                 {"table" => "pc_apps", 
                  "column" => "mm_admin_password", 
                  "comment" => "the password for basic authentication with admin host"},
                  
               ]
    
    columns.each do |col|
      add_column col["table"].to_sym, col["column"].to_sym, :string, :limit => 255, :comment => col["comment"]
      db.execute("UPDATE #{col["table"]} SET #{col["column"]} = 'a'")
      change_column col["table"].to_sym, col["column"].to_sym, :string, :null => false
    end
  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
end
