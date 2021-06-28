class AddDailyEventFeeToSimulation < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :page_view_fee, :float
    add_column :simulations, :day_page_view_fee, :bigint
	add_column :simulations, :week_page_view_fee, :bigint
	add_column :simulations, :month_page_view_fee, :bigint
	add_column :simulations, :annual_page_view_fee, :bigint

	add_column :simulations, :total_wifi_lp_single, :float
	add_column :simulations, :total_wifi_lp_annual, :float
	add_column :simulations, :total_wifi_lp_month, :float
	add_column :simulations, :total_wifi_lp_week, :float
  end
end
