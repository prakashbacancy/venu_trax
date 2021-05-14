class CreateVenues < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.string :domain
      t.string :name
      t.string :phone_no
      t.string :zip_code
      t.text :address
      t.string :city
      t.string :state
      t.text :description
      t.integer :no_of_employee, default: 0
      t.references :business
      t.timestamps
    end
  end
end
