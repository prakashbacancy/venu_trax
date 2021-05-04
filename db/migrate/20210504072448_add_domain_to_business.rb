class AddDomainToBusiness < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :domain, :string
  end
end
