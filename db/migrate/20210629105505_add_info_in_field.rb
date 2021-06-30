class AddInfoInField < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :info, :text, default: ''
  end
end
