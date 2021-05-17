class AddWeekMonthCapacity < ActiveRecord::Migration[6.1]
  def change
  	add_column :simulations, :week_seating_capacity, :bigint
  	add_column :simulations, :month_seating_capacity, :bigint

  	add_column :simulations, :week_attendance_event, :bigint
  	add_column :simulations, :month_attendance_event, :bigint

  	add_column :simulations, :wifi_lp_week_login, :bigint
  	add_column :simulations, :wifi_lp_month_login, :bigint

  	add_column :simulations, :lp_rev_month_total, :bigint
  	add_column :simulations, :lp_rev_week_total, :bigint

  	add_column :simulations, :user_impression_month, :bigint
  	add_column :simulations, :user_impression_week, :bigint

  	add_column :simulations, :cpm_impression_month, :bigint
  	add_column :simulations, :cpm_impression_week, :bigint

  	add_column :simulations, :wifi_annual_month, :bigint
  	add_column :simulations, :wifi_annual_week, :bigint

  	add_column :simulations, :day_seating_capacity, :bigint
	add_column :simulations, :day_attendance_event, :bigint
	add_column :simulations, :wifi_lp_day_login, :bigint
	add_column :simulations, :lp_rev_day_total, :bigint
	add_column :simulations, :user_impression_day, :bigint
	add_column :simulations, :cpm_impression_day, :bigint

	add_column :simulations, :wifi_annual_month_total, :bigint
	add_column :simulations, :wifi_annual_week_total, :bigint
	add_column :simulations, :wifi_annual_day_total, :bigint

  end
end
