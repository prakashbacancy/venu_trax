class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name
      # t.references :venue, foreign_key: true
      t.timestamps
    end
  end
end
