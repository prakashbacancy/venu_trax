class CreateBrandContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :brand_contacts do |t|
      t.string :email
      t.string :full_name
    	t.string :phone_no
    	t.string :job_title
    	t.bigint :brand_id
      t.timestamps
    end
  end
end
