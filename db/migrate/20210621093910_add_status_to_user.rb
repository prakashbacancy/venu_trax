class AddStatusToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :status, :string, default: 'invited'

    # Update existing data according to real status
    User.update_all(status: 'active')
    User.where(encrypted_password: '').update_all(status: 'invited')
  end
end
