class AddReadonlyToField < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :read_only, :boolean, default: false
  end
end
