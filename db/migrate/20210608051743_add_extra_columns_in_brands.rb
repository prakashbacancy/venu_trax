class AddExtraColumnsInBrands < ActiveRecord::Migration[6.1]
  def change
  	add_column :brands, :domain_name, :string
  	add_column :brands, :phone_number, :string
  	add_column :brands, :website_url, :string
  	add_column :brands, :city, :string
  	add_column :brands, :state, :string
  	add_column :brands, :zip_code, :string
  	add_column :brands, :no_of_employee, :integer
  	add_column :brands, :annual_revenue, :float
  	add_column :brands, :brand_owner, :string
  	add_column :brands, :country, :string
  	add_column :brands, :street_address, :string
  	add_column :brands, :description, :string
    add_column :brands, :venue_id, :integer
  end
end
