class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :note
      t.string :file
      t.references :attachable, :polymorphic => true
      t.string :user_id

      t.timestamps
    end
    add_index :attachments, :attachable_id
  end
end
