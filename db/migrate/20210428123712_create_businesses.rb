class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :industry
      t.string :business_type
      t.string :phone_no
      t.string :zip_code
      t.text :address
      t.string :city
      t.string :state
      t.integer :no_of_employee, default: 0
      t.float :annual_revenue, default: 0.0
      t.text :description

      t.timestamps
    end
  end
end
