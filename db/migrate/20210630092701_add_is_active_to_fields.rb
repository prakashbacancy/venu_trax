class AddIsActiveToFields < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :is_active, :boolean, default: true
  end
end
