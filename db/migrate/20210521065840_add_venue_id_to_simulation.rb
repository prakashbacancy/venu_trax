class AddVenueIdToSimulation < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :venue_id, :integer
    add_column :simulations, :cpa_impression_cost, :float
    add_column :simulations, :cpa_annual_login, :float
	add_column :simulations, :cpa_week_login, :float
	add_column :simulations, :cpa_month_login, :float
	add_column :simulations, :cpa_day_login, :float
  end
end
