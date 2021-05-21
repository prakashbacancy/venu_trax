class AddGmailColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :google_code, :string
    add_column :users, :google_access_token, :string
    add_column :users, :google_refresh_token, :string
    add_column :users, :signature, :text
    add_column :users, :google_email, :string
    add_column :users, :google_token_expired_at, :datetime
  end
end
