class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.string :label
      t.string :column_type
      t.references :klass, foreign_key: true
      t.integer :position
      t.string :placeholder
      t.integer :min_length
      t.integer :max_length
      t.string :default_value
      t.boolean :required, default: false
      t.boolean :deletable, default: true
      t.boolean :custom, default: true
      t.timestamps
    end
  end
end
