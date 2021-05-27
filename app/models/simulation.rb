class Simulation < ApplicationRecord
	PERMITTED_PARAM = %w[event_per_year daily_seating_capacity annual_attendance_per visitor_wifi_login
cost_lp_impression event_usage_impression cpm_impression_cost contract_month cpa_impression_cost venue_id event_type user_id]
	CHART_OPTIONS = %W[All Today Weekly Monthly Annually]
	SELECT_OPTIONS = %W[Daily Weekly Monthly Annually]

	enum event_type: %W[Daily Weekly Monthly Annually]
	after_save :update_simulation_records

	def update_simulation_records
		weeks = weeks_count(Date.today.year)
		months = 12
		days = Date.new(Date.today.year,12,31).yday
		
		total_event =  case event_type
		when "Daily"
			event_per_year * days
		when "Weekly"
			event_per_year * weeks
		when "Monthly"
			event_per_year * months
		when "Annually"
			event_per_year
		end

		annual_seating_capacity = total_event * daily_seating_capacity
		month_seating_capacity = annual_seating_capacity / months 
		week_seating_capacity = annual_seating_capacity / weeks
		day_seating_capacity = annual_seating_capacity / days

		avg_attendance_event = (annual_seating_capacity / total_event * (annual_attendance_per.to_f/100))
		avg_attendance_annual_event = total_event * avg_attendance_event
		week_attendance_event = (avg_attendance_annual_event.to_f / weeks)
		month_attendance_event = (avg_attendance_annual_event.to_f / months)
		day_attendance_event = (avg_attendance_annual_event / days)

		wifi_lp_per_day_login = avg_attendance_event * (visitor_wifi_login.to_f/100)
		wifi_lp_annual_login = avg_attendance_annual_event * (visitor_wifi_login.to_f/100)
		wifi_lp_week_login = (wifi_lp_annual_login.to_f / weeks)
		wifi_lp_month_login = (wifi_lp_annual_login.to_f / months)
		wifi_lp_day_login = (wifi_lp_per_day_login.to_f / days)

		lp_rev_per_day_total =  wifi_lp_per_day_login * cost_lp_impression
		lp_rev_annual_total  =	wifi_lp_annual_login * cost_lp_impression
		lp_rev_month_total = (lp_rev_annual_total.to_f / months)
		lp_rev_week_total = (lp_rev_annual_total.to_f / weeks)
		lp_rev_day_total = (lp_rev_per_day_total.to_f / days)

		cpa_per_day_login = wifi_lp_per_day_login * cpa_impression_cost
		cpa_annual_login = wifi_lp_annual_login * cpa_impression_cost
		cpa_week_login = (cpa_annual_login.to_f / weeks)
		cpa_month_login = (cpa_annual_login.to_f / months)
		cpa_day_login = (cpa_per_day_login.to_f / days)


		user_impression_per_day = wifi_lp_per_day_login * event_usage_impression
		user_impression_annual = wifi_lp_annual_login * event_usage_impression
		user_impression_month = (user_impression_annual.to_f / months)
		user_impression_week = (user_impression_annual.to_f  / weeks)
		user_impression_day = (user_impression_per_day.to_f / days)

		cpm_impression_per_day = user_impression_per_day * cpm_impression_cost
		cpm_impression_annual = cpm_impression_per_day * total_event
		cpm_impression_month = (cpm_impression_annual.to_f / months)
		cpm_impression_week = (cpm_impression_annual.to_f / weeks)
		cpm_impression_day = cpm_impression_per_day / days

		wifi_annual_total = cpm_impression_annual * contract_month
		wifi_annual_month_total = (wifi_annual_total.to_f / months)
		wifi_annual_week_total = (wifi_annual_total.to_f / weeks)
		wifi_annual_day_total = (wifi_annual_total.to_f / days)
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
												wifi_annual_day_total: wifi_annual_day_total,
												cpa_per_day_login: cpa_per_day_login,
												cpa_annual_login: cpa_annual_login,
												cpa_week_login: cpa_week_login,
												cpa_month_login: cpa_month_login,
												cpa_day_login: cpa_day_login
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
