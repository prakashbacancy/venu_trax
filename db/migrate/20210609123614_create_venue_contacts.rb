class CreateVenueContacts < ActiveRecord::Migration[6.1]
  # NOTE: To give dynamic settings individually in Venue Contacts and Brand Contacts,
  #       we are not using polymorphism for Contacts
  def change
    create_table :venue_contacts do |t|
      t.string :email
      t.string :full_name
      t.string :phone_no
      t.string :job_title
      t.references :user
      t.references :venue
      t.timestamps
    end
  end
end
