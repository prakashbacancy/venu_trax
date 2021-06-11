class AddContactToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact, :integer, default: 0
  end
end
