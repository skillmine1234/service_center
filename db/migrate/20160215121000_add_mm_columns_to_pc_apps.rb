class AddMmColumnsToPcApps < ActiveRecord::Migration
  def change
    columns = [ {"table" => "pc_apps", 
                 "column" => "mm_host", 
                 "comment" => "the MatchMove host URI"}, 
                 
                 {"table" => "pc_apps", 
                  "column" => "mm_consumer_key", 
                  "comment" => "the oauth consumer key shared by MatchMove"},
                
                 {"table" => "pc_apps", 
                  "column" => "mm_consumer_secret", 
                  "comment" => "the outh consumer secret shared by MatchMove"},
                  
                 {"table" => "pc_apps", 
                  "column" => "mm_card_type", 
                  "comment" => "the card type, used while reigestering cards"},
                  
                 {"table" => "pc_apps", 
                  "column" => "mm_email_domain", 
                  "comment" => "the email domain to use, when creating an email address for a user"}
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
