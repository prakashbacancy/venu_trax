class SimulationChart
	def initialize(params)
		@params = params
	end

	def calculation
		data = {}
		set_date_filter
		simulation = Simulation.all
    daily_data = simulation.where(created_at: @today)
    week_data = simulation.where(created_at: @week)
    month_data = simulation.where(created_at: @month)
    year_data = simulation.where(created_at: @year)
		seating_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
    vistior_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
    wifilp_login_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
    lp_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    user_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    cpm_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    wifi_revenue_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
		data
	end

	def set_date_filter
  	@today = Date.today.beginning_of_day..Date.today.end_of_day
    @week = Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day
    @month = Date.today.beginning_of_month.beginning_of_day..Date.today.end_of_month.end_of_day
    @year = Date.today.beginning_of_year.beginning_of_day..Date.today.end_of_year.end_of_day
  end
  def seating_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily = daily_data.sum(:annual_seating_capacity)
    week = week_data.sum(:annual_seating_capacity)
    month = month_data.sum(:annual_seating_capacity)
    year = year_data.sum(:annual_seating_capacity)
    @date_range = case params[:option]
    when 'Today'
      data[:seating_capacity] = simulation.where(created_at: @today).group_by_day(:created_at).sum(:annual_seating_capacity)
    when 'Weekly'
      data[:seating_capacity] = simulation.where(created_at: @week).group_by_day(:created_at).sum(:annual_seating_capacity)
    when 'Monthly'
      data[:seating_capacity] = simulation.where(created_at: @month).group_by_week(:created_at, week_start: :monday).sum(:annual_seating_capacity)
    when 'Annually'
      data[:seating_capacity] = simulation.where(created_at: @month).group_by_month(:created_at).sum(:annual_seating_capacity)
    else
      data[:seating_capacity] = {'Daily' => daily, 'Weekly'=> week, 'Monthly' => month, 'Annually' => year }
    end
   data[:daily_seating_capacity] = daily
   data[:week_seating_capacity] = week
   data[:month_seating_capacity] = month
   data[:year_seating_capacity] = year

  end
  def vistior_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_visitor = daily_data.sum(:avg_attendance_event)
    week_visitor = week_data.sum(:avg_attendance_event)
    month_visitor = month_data.sum(:avg_attendance_event)
    year_visitor = year_data.sum(:avg_attendance_event)

    daily_annual_visitor = daily_data.sum(:avg_attendance_annual_event)
    week_annual_visitor = week_data.sum(:avg_attendance_annual_event)
    month_annual_visitor = month_data.sum(:avg_attendance_annual_event)
    year_annual_visitor = year_data.sum(:avg_attendance_annual_event)

    @date_range = case params[:option]
      when 'Today'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => daily_data.group_by_day(:created_at).sum(:avg_attendance_event).collect{|k,v| [k.to_s + '_', v]}.to_h },
               { 'name' => 'Annually  Attendance',
                 'data' => daily_data.group_by_day(:created_at).sum(:avg_attendance_annual_event).collect{|k,v| [k.to_s + '_', v]}.to_h }]
      when 'Weekly'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => week_data.group_by_day(:created_at).sum(:avg_attendance_event).collect{|k,v| [k.to_s + '_', v]}.to_h },
               { 'name' => 'Annually  Attendance',
                 'data' => week_data.group_by_day(:created_at).sum(:avg_attendance_annual_event).collect{|k,v| [k.to_s + '_', v]}.to_h }]
      when 'Monthly'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:avg_attendance_event) },
               { 'name' => 'Annually  Attendance',
                 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:avg_attendance_annual_event) }]
      when 'Annually'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => year_data.group_by_month(:created_at).sum(:avg_attendance_event) },
               { 'name' => 'Annually  Attendance',
                 'data' => year_data.group_by_month(:created_at).sum(:avg_attendance_annual_event) }]
      else
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => {'Daily' => daily_visitor, 'Weekly'=> week_visitor, 'Monthly' => month_visitor, 'Annually' => year_visitor }},{'name' => 'Annually Attendance', 'data' => {'Daily' => daily_annual_visitor, 'Weekly'=> week_annual_visitor, 'Monthly' => month_annual_visitor, 'Annually' => year_annual_visitor }}]
      end
    data[:daily_visitor_attendance] = daily_visitor
    data[:week_visitor_attendance] = week_visitor
    data[:month_visitor_attendance] = month_visitor
    data[:year_visitor_attendance] = month_visitor

    data[:daily_annual_visitor] = daily_annual_visitor
    data[:week_annual_visitor] = week_annual_visitor
    data[:month_annual_visitor] = month_annual_visitor
    data[:year_annual_visitor] = year_annual_visitor
  end
  
  def wifilp_login_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_wifi_lp_login = daily_data.sum(:wifi_lp_per_day_login)
    week_wifi_lp_login = week_data.sum(:wifi_lp_per_day_login)
    month_wifi_lp_login = month_data.sum(:wifi_lp_per_day_login)
    year_wifi_lp_login = year_data.sum(:wifi_lp_per_day_login)

    daily_annual_wifi_lp_login = daily_data.sum(:wifi_lp_annual_login)
    week_annual_wifi_lp_login = week_data.sum(:wifi_lp_annual_login)
    month_annual_wifi_lp_login = month_data.sum(:wifi_lp_annual_login)
    year_annual_wifi_lp_login = year_data.sum(:wifi_lp_annual_login)

    @date_range = case params[:option]
      when 'Today'
        data[:wifi_lp_login] = [{'name' => 'Per day', 'data' => daily_data.group_by_day(:created_at).sum(:wifi_lp_per_day_login) },
               { 'name' => 'Annually  Attendance',
                 'data' => daily_data.group_by_day(:created_at).sum(:wifi_lp_annual_login) }]
      when 'Weekly'
        data[:wifi_lp_login] = [{'name' => 'Per day', 'data' => week_data.group_by_day(:created_at).sum(:wifi_lp_per_day_login) },
               { 'name' => 'Annually  Attendance',
                 'data' => week_data.group_by_day(:created_at).sum(:wifi_lp_annual_login) }]
      when 'Monthly'
        data[:wifi_lp_login] = [{'name' => 'Per day', 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:wifi_lp_per_day_login) },
               { 'name' => 'Annually  Attendance',
                 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:wifi_lp_annual_login) }]
      when 'Annually'
        data[:wifi_lp_login] = [{'name' => 'Per day', 'data' => year_data.group_by_month(:created_at).sum(:wifi_lp_per_day_login) },
               { 'name' => 'Annually  Attendance',
                 'data' => year_data.group_by_month(:created_at).sum(:wifi_lp_annual_login) }]
      else
        data[:wifi_lp_login] = [{'name' => 'Per day', 'data' => {'Daily' => daily_wifi_lp_login, 'Weekly'=> week_wifi_lp_login, 'Monthly' => month_wifi_lp_login, 'Annually' => year_wifi_lp_login }},{'name' => 'Annually Attendance', 'data' => {'Daily' => daily_annual_wifi_lp_login, 'Weekly'=> week_annual_wifi_lp_login, 'Monthly' => month_annual_wifi_lp_login, 'Annually' => year_annual_wifi_lp_login }}]
      end
    data[:daily_wifi_lp_login] = daily_wifi_lp_login
    data[:week_wifi_lp_login] = week_wifi_lp_login
    data[:month_wifi_lp_login] = month_wifi_lp_login
    data[:year_wifi_lp_login] = month_wifi_lp_login

    data[:daily_annual_wifi_lp_login] = daily_annual_wifi_lp_login
    data[:week_annual_wifi_lp_login] = week_annual_wifi_lp_login
    data[:month_annual_wifi_lp_login] = month_annual_wifi_lp_login
    data[:year_annual_wifi_lp_login] = year_annual_wifi_lp_login
  end

  def lp_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_lp_impression = daily_data.sum(:lp_rev_per_day_total)
    week_lp_impression = week_data.sum(:lp_rev_per_day_total)
    month_lp_impression = month_data.sum(:lp_rev_per_day_total)
    year_lp_impression = year_data.sum(:lp_rev_per_day_total)

    daily_annual_lp_impression = daily_data.sum(:lp_rev_annual_total)
    week_annual_lp_impression = week_data.sum(:lp_rev_annual_total)
    month_annual_lp_impression = month_data.sum(:lp_rev_annual_total)
    year_annual_lp_impression = year_data.sum(:lp_rev_annual_total)

    @date_range = case params[:option]
      when 'Today'
        data[:lp_impression] = [{'name' => 'Per day', 'data' => daily_data.group_by_day(:created_at).sum(:lp_rev_per_day_total) },
               { 'name' => 'Annually  Attendance',
                 'data' => daily_data.group_by_day(:created_at).sum(:lp_rev_annual_total) }]
      when 'Weekly'
        data[:lp_impression] = [{'name' => 'Per day', 'data' => week_data.group_by_day(:created_at).sum(:lp_rev_per_day_total) },
               { 'name' => 'Annually  Attendance',
                 'data' => week_data.group_by_day(:created_at).sum(:lp_rev_annual_total) }]
      when 'Monthly'
        data[:lp_impression] = [{'name' => 'Per day', 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:lp_rev_per_day_total) },
               { 'name' => 'Annually  Attendance',
                 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:lp_rev_annual_total) }]
      when 'Annually'
        data[:lp_impression] = [{'name' => 'Per day', 'data' => year_data.group_by_month(:created_at).sum(:lp_rev_per_day_total) },
               { 'name' => 'Annually  Attendance',
                 'data' => year_data.group_by_month(:created_at).sum(:lp_rev_annual_total) }]
      else
        data[:lp_impression] = [{'name' => 'Per day', 'data' => {'Daily' => daily_lp_impression, 'Weekly'=> week_lp_impression, 'Monthly' => month_lp_impression, 'Annually' => year_lp_impression }},{'name' => 'Annual Attendance', 'data' => {'Daily' => daily_annual_lp_impression, 'Weekly'=> week_annual_lp_impression, 'Monthly' => month_annual_lp_impression, 'Annually' => year_annual_lp_impression }}]
      end
    data[:daily_lp_impression] = daily_lp_impression
    data[:week_lp_impression] = week_lp_impression
    data[:month_lp_impression] = month_lp_impression
    data[:year_lp_impression] = year_lp_impression

    data[:daily_annual_lp_impression] = daily_annual_lp_impression
    data[:week_annual_lp_impression] = week_annual_lp_impression
    data[:month_annual_lp_impression] = month_annual_lp_impression
    data[:year_annual_lp_impression] = year_annual_lp_impression
  end

  def user_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_user_impression = daily_data.sum(:user_impression_per_day)
    week_user_impression = week_data.sum(:user_impression_per_day)
    month_user_impression = month_data.sum(:user_impression_per_day)
    year_user_impression = year_data.sum(:user_impression_per_day)

    daily_annual_user_impression = daily_data.sum(:user_impression_annual)
    week_annual_user_impression = week_data.sum(:user_impression_annual)
    month_annual_user_impression = month_data.sum(:user_impression_annual)
    year_annual_user_impression = year_data.sum(:user_impression_annual)

    @date_range = case params[:option]
      when 'Today'
        data[:user_impression] = [{'name' => 'Per day', 'data' => daily_data.group_by_day(:created_at).sum(:user_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => daily_data.group_by_day(:created_at).sum(:user_impression_annual) }]
      when 'Weekly'
        data[:user_impression] = [{'name' => 'Per day', 'data' => week_data.group_by_day(:created_at).sum(:user_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => week_data.group_by_day(:created_at).sum(:user_impression_annual) }]
      when 'Monthly'
        data[:user_impression] = [{'name' => 'Per day', 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:user_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:user_impression_annual) }]
      when 'Annually'
        data[:user_impression] = [{'name' => 'Per day', 'data' => year_data.group_by_month(:created_at).sum(:user_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => year_data.group_by_month(:created_at).sum(:user_impression_annual) }]
      else
        data[:user_impression] = [{'name' => 'Per day', 'data' => {'Daily' => daily_user_impression, 'Weekly'=> week_user_impression, 'Monthly' => month_user_impression, 'Annually' => year_user_impression }},{'name' => 'Annual Attendance', 'data' => {'Daily' => daily_annual_user_impression, 'Weekly'=> week_annual_user_impression, 'Monthly' => month_annual_user_impression, 'Annually' => year_annual_user_impression }}]
      end
    data[:daily_user_impression] = daily_user_impression
    data[:week_user_impression] = week_user_impression
    data[:month_user_impression] = month_user_impression
    data[:year_user_impression] = year_user_impression

    data[:daily_annual_user_impression] = daily_annual_user_impression
    data[:week_annual_user_impression] = week_annual_user_impression
    data[:month_annual_user_impression] = month_annual_user_impression
    data[:year_annual_user_impression] = year_annual_user_impression
  end

  def cpm_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_cpm_impression = daily_data.sum(:cpm_impression_per_day)
    week_cpm_impression = week_data.sum(:cpm_impression_per_day)
    month_cpm_impression = month_data.sum(:cpm_impression_per_day)
    year_cpm_impression = year_data.sum(:cpm_impression_per_day)

    daily_annual_cpm_impression = daily_data.sum(:cpm_impression_annual)
    week_annual_cpm_impression = week_data.sum(:cpm_impression_annual)
    month_annual_cpm_impression = month_data.sum(:cpm_impression_annual)
    year_annual_cpm_impression = year_data.sum(:cpm_impression_annual)

    @date_range = case params[:option]
      when 'Today'
        data[:cpm_impression] = [{'name' => 'Per day', 'data' => daily_data.group_by_day(:created_at).sum(:cpm_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => daily_data.group_by_day(:created_at).sum(:cpm_impression_annual) }]
      when 'Weekly'
        data[:cpm_impression] = [{'name' => 'Per day', 'data' => week_data.group_by_day(:created_at).sum(:cpm_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => week_data.group_by_day(:created_at).sum(:cpm_impression_annual) }]
      when 'Monthly'
        data[:cpm_impression] = [{'name' => 'Per day', 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:cpm_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => month_data.group_by_week(:created_at, week_start: :monday).sum(:cpm_impression_annual) }]
      when 'Annually'
        data[:cpm_impression] = [{'name' => 'Per day', 'data' => year_data.group_by_month(:created_at).sum(:cpm_impression_per_day) },
               { 'name' => 'Annually  Attendance',
                 'data' => year_data.group_by_month(:created_at).sum(:cpm_impression_annual) }]
      else
        data[:cpm_impression] = [{'name' => 'Per day', 'data' => {'Daily' => daily_cpm_impression, 'Weekly'=> week_cpm_impression, 'Monthly' => month_cpm_impression, 'Annually' => year_cpm_impression }},{'name' => 'Annual Attendance', 'data' => {'Daily' => daily_annual_cpm_impression, 'Weekly'=> week_annual_cpm_impression, 'Monthly' => month_annual_cpm_impression, 'Annually' => year_annual_cpm_impression }}]
      end
    data[:daily_cpm_impression] = daily_cpm_impression
    data[:week_cpm_impression] = week_cpm_impression
    data[:month_cpm_impression] = month_cpm_impression
    data[:year_cpm_impression] = year_cpm_impression

    data[:daily_annual_cpm_impression] = daily_annual_cpm_impression
    data[:week_annual_cpm_impression] = week_annual_cpm_impression
    data[:month_annual_cpm_impression] = month_annual_cpm_impression
    data[:year_annual_cpm_impression] = year_annual_cpm_impression
  end

  def wifi_revenue_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily = simulation.where(created_at: @today).sum(:wifi_annual_total)
    week = simulation.where(created_at: @week).sum(:wifi_annual_total)
    month = simulation.where(created_at: @month).sum(:wifi_annual_total)
    year = simulation.where(created_at: @year).sum(:wifi_annual_total)
     @date_range = case params[:option]
      when 'Today'
        data[:wifi_revenue] = simulation.daily_data.group_by_day(:created_at).sum(:wifi_annual_total).collect{|k,v| [k.to_s + '_', v]}.to_h
      when 'Weekly'
        data[:wifi_revenue] = simulation.week_data.group_by_day(:created_at).sum(:wifi_annual_total).collect{|k,v| [k.to_s + '_', v]}.to_h
      when 'Monthly'
        data[:wifi_revenue] = month_data.group_by_week(:created_at, week_start: :monday).sum(:wifi_annual_total)
      when 'Annually'
        data[:wifi_revenue] = year_data.group_by_month(:created_at).sum(:wifi_annual_total)
      else
        data[:wifi_revenue] = {'Daily' => daily, 'Weekly'=> week, 'Monthly' => month, 'Annually' => year }
      end
    data[:daily_wifi_revenue] = daily
    data[:week_wifi_revenue] = week
    data[:month_wifi_revenue] = month
    data[:year_wifi_revenue] = year
  end

end