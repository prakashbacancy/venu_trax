class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
    	t.bigint "venue_id"
	    t.string "attachable_type"
	    t.bigint "attachable_id"
      t.timestamps
    end
  end
end
