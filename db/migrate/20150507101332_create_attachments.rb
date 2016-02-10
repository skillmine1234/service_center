class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :note
      t.string :file
      t.references :attachable, :polymorphic => true
      t.string :user_id

      t.timestamps
    end
    add_index :attachments, :attachable_id
  end
end
