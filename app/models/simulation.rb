class Simulation < ApplicationRecord
	PERMITTED_PARAM = %w[event_per_year daily_seating_capacity annual_attendance_per visitor_wifi_login
cost_lp_impression event_usage_impression cpm_impression_cost contract_month]
	CHART_OPTIONS = %W[All Today Weekly Monthly Annually]
	after_save :update_simulation_records

	def update_simulation_records
		months = 12
		weeks = 48 #weeks_count(Date.today.year)


		annual_seating_capacity = (event_per_year * weeks) * daily_seating_capacity
		week_seating_capacity = (event_per_year.to_f) * daily_seating_capacity
		month_seating_capacity = (event_per_year.to_f * 4) * daily_seating_capacity
		day_seating_capacity = (daily_seating_capacity * (event_per_year.to_f * weeks) / 365)

		avg_attendance_event = (annual_seating_capacity / (event_per_year * weeks) * (annual_attendance_per/100))
		avg_attendance_annual_event = (event_per_year * weeks) * avg_attendance_event
		week_attendance_event = (avg_attendance_annual_event.to_f/weeks)
		month_attendance_event = (avg_attendance_annual_event.to_f/months)
		day_attendance_event = (avg_attendance_event * ((event_per_year.to_f * weeks) / 365))

		wifi_lp_per_day_login = avg_attendance_event * (visitor_wifi_login/100)
		wifi_lp_annual_login = avg_attendance_annual_event * (visitor_wifi_login/100)
		wifi_lp_week_login = (wifi_lp_annual_login.to_f / weeks)
		wifi_lp_month_login = (wifi_lp_annual_login.to_f / months)
		wifi_lp_day_login = (wifi_lp_per_day_login.to_f * ((event_per_year.to_f * weeks) / 365))

		lp_rev_per_day_total =  wifi_lp_per_day_login * cost_lp_impression
		lp_rev_annual_total  =	wifi_lp_annual_login * cost_lp_impression
		lp_rev_month_total = (lp_rev_annual_total.to_f / months)
		lp_rev_week_total = (lp_rev_annual_total.to_f / weeks)
		lp_rev_day_total = (lp_rev_per_day_total.to_f * ((event_per_year.to_f * weeks) / 365))

		user_impression_per_day = wifi_lp_per_day_login * event_usage_impression
		user_impression_annual = wifi_lp_annual_login * event_usage_impression
		user_impression_month = (user_impression_annual.to_f / months)
		user_impression_week = (user_impression_annual.to_f  / weeks)
		user_impression_day = (user_impression_per_day.to_f * ((event_per_year.to_f * weeks) / 365))

		cpm_impression_per_day = user_impression_per_day * cpm_impression_cost
		cpm_impression_annual = cpm_impression_per_day * (event_per_year.to_f * weeks)
		cpm_impression_month = (cpm_impression_annual.to_f / months)
		cpm_impression_week = (cpm_impression_annual.to_f / weeks)
		cpm_impression_day = cpm_impression_per_day * ((event_per_year.to_f * weeks) / 365)

		wifi_annual_total = cpm_impression_annual * contract_month
		wifi_annual_month_total = (wifi_annual_total.to_f / months)
		wifi_annual_week_total = (wifi_annual_total.to_f / weeks)
		wifi_annual_day_total = (wifi_annual_total.to_f / (weeks * 7) )
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
												annual_seating_capacity: annual_seating_capacity,
												week_seating_capacity: week_seating_capacity,
												month_seating_capacity: month_seating_capacity,
												week_attendance_event: week_attendance_event,
												month_attendance_event: month_attendance_event,
												wifi_lp_week_login: wifi_lp_week_login,
												wifi_lp_month_login: wifi_lp_month_login,
												lp_rev_month_total: lp_rev_month_total,
												lp_rev_week_total: lp_rev_week_total,
												user_impression_month: user_impression_month,
												user_impression_week: user_impression_week,
												cpm_impression_month: cpm_impression_month,
												cpm_impression_week: cpm_impression_week,
												day_seating_capacity: day_seating_capacity,
												day_attendance_event: day_attendance_event,
												wifi_lp_day_login: wifi_lp_day_login,
												lp_rev_day_total: lp_rev_day_total,
												user_impression_day: user_impression_day,
												cpm_impression_day: cpm_impression_day,
												wifi_annual_month_total: wifi_annual_month_total,
												wifi_annual_week_total: wifi_annual_week_total,
												wifi_annual_day_total: wifi_annual_day_total
												)

	end

	def weeks_count(year)
	  last_day = Date.new(year).end_of_year
	  if last_day.cweek == 1
	    last_day.prev_week.cweek
	  else
	    last_day.cweek
	  end
	end
end
