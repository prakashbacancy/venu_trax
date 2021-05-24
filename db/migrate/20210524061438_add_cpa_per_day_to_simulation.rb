class AddCpaPerDayToSimulation < ActiveRecord::Migration[6.1]
  def change
	add_column :simulations, :cpa_per_day_login, :float
  end
end
