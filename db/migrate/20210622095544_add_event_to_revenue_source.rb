class AddEventToRevenueSource < ActiveRecord::Migration[6.1]
  def change
    add_reference :revenue_sources, :event
  end
end
