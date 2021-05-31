class AddHiddenToField < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :hidden, :boolean, default: false
  end
end
