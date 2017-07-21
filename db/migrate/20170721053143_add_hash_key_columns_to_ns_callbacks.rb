class AddHashKeyColumnsToNsCallbacks < ActiveRecord::Migration
  def change
    add_column :ns_callbacks, :sc_service_id, :integer, comment: 'the service with which this record is associated to'
    add_column :ns_callbacks, :include_hash, :string, limit: 1, default: 'N', comment: 'the flag which indicates whether this callback needs hash key or not'
    add_column :ns_callbacks, :hash_header_name, :string, limit: 100, comment: 'the header name for the hash key'
    add_column :ns_callbacks, :hash_algo, :string, limit: 100, comment: 'the name of the algorithm to determine the hash key'
    add_column :ns_callbacks, :hash_key, :string, limit: 255, comment: 'the hash key for this record'
  end
end
