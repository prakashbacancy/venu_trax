class CreateRevenueSources < ActiveRecord::Migration[6.1]
  def change
    create_table :revenue_sources do |t|
      t.references :brand
      t.string :name

      # Rates
      t.float :cpc
      t.float :cpm
      t.float :cpa

      t.text :description
      t.references :venue
      t.timestamps
    end
  end
end
