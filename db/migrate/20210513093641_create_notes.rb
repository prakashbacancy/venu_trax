class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.text :description
      t.references :user
      t.references :notable, polymorphic: true
      t.timestamps
    end
  end
end
