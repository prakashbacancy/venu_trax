class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :description
      t.integer :status, default: 0
      t.integer :assigned_to
      t.string :created_by
      t.timestamps
    end
  end
end
