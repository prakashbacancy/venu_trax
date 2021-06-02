class AddGroupIdToFields < ActiveRecord::Migration[6.1]
  def change
    add_reference :fields, :group, foreign_key: true
  end
end
