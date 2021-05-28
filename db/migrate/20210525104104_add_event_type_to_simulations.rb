class AddEventTypeToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :event_type, :integer, default: 1
    add_column :simulations, :user_id, :integer
  end
end
