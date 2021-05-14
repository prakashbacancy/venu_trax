class Simulation < ApplicationRecord
	PERMITTED_PARAM = %w[event_per_year daily_seating_capacity annual_attendance_per visitor_wifi_login
cost_lp_impression event_usage_impression cpm_impression_cost contract_month]
	CHART_OPTIONS = %W[All Today Weekly Monthly Annually]
	after_save :update_simulation_records

	def update_simulation_records
		annual_seating_capacity = event_per_year * daily_seating_capacity

		avg_attendance_event = (annual_seating_capacity / event_per_year * (annual_attendance_per/100))
		avg_attendance_annual_event = event_per_year * avg_attendance_event

		wifi_lp_per_day_login = avg_attendance_event * (visitor_wifi_login/100)
		wifi_lp_annual_login = annual_seating_capacity * (annual_attendance_per/100)

		lp_rev_per_day_total =  wifi_lp_per_day_login * cost_lp_impression
		lp_rev_annual_total  =	wifi_lp_annual_login * cost_lp_impression

		user_impression_per_day = wifi_lp_per_day_login * event_usage_impression
		user_impression_annual = wifi_lp_annual_login * event_usage_impression

		cpm_impression_per_day = user_impression_per_day * cpm_impression_cost
		cpm_impression_annual = cpm_impression_per_day * event_per_year

		wifi_annual_total = cpm_impression_annual * contract_month
		
		self.update_columns(
												wifi_annual_total: wifi_annual_total,
												cpm_impression_annual: cpm_impression_annual,
												cpm_impression_per_day: cpm_impression_per_day,
												user_impression_per_day: user_impression_per_day,
												user_impression_annual: user_impression_annual,
												lp_rev_per_day_total: lp_rev_per_day_total,
												lp_rev_annual_total: lp_rev_annual_total,
												wifi_lp_per_day_login: wifi_lp_per_day_login,
												wifi_lp_annual_login: wifi_lp_annual_login,
												avg_attendance_event: avg_attendance_event,
												avg_attendance_annual_event: avg_attendance_annual_event,
												annual_seating_capacity: annual_seating_capacity
												)

	end
end
