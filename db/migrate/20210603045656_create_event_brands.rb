class CreateEventBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :event_brands do |t|
      t.references :event, foreign_key: true
      t.references :brand, foreign_key: true
      t.timestamps
    end
  end
end
