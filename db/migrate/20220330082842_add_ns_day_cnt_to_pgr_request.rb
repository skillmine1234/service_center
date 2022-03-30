class AddNsDayCntToPgrRequest < ActiveRecord::Migration
  def change
    add_column :pgr_requests, :ns_day_cnt, :string
  end
end
