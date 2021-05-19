class CreateKlasses < ActiveRecord::Migration[6.1]
  def change
    create_table :klasses do |t|
      t.string :name
      t.string :label
      t.timestamps
    end
  end
end
