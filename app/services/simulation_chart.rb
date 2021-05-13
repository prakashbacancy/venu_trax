class SimulationChart
	def initialize(params)
		@params = params
	end

	def calculation
		data = {}
		set_date_filter
		simulation = Simulation.all
		seating_chart(@params, simulation, data)
    vistior_chart(@params, simulation, data)
		data
	end

	def set_date_filter
  	@today = Date.today.beginning_of_day..Date.today.end_of_day
    @week = Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day
    @month = Date.today.beginning_of_month.beginning_of_day..Date.today.end_of_month.end_of_day
    @year = Date.today.beginning_of_year.beginning_of_day..Date.today.end_of_year.end_of_day
  end
  def seating_chart(params, simulation, data)	
    daily = simulation.where(created_at: @today).sum(:annual_seating_capacity)
  	week = simulation.where(created_at: @week).sum(:annual_seating_capacity)
  	month = simulation.where(created_at: @month).sum(:annual_seating_capacity)
	  year = simulation.where(created_at: @year).sum(:annual_seating_capacity)
  	 @date_range = case params[:option]
      when 'Today'
        data[:seating_capacity] = simulation.where(created_at: @today).group_by_day(:created_at).sum(:annual_seating_capacity)
      when 'Weekly'
        data[:seating_capacity] = simulation.where(created_at: @week).group_by_day(:created_at).sum(:annual_seating_capacity)
      when 'Monthly'
        data[:seating_capacity] = simulation.where(created_at: @month).group_by_week(:created_at).sum(:annual_seating_capacity)
      when 'Annually'
        data[:seating_capacity] = simulation.where(created_at: @month).group_by_month(:created_at).sum(:annual_seating_capacity)
      else
		  	data[:seating_capacity] = {'Daily' => daily, 'Weekly'=> week, 'Monthly' => month, 'Annualy' => year }
      end
    data[:daily_seating_capacity] = daily
    data[:week_seating_capacity] = week
    data[:month_seating_capacity] = month
    data[:year_seating_capacity] = year
  end
  def vistior_chart(params, simulation, data)
    # visitor = [{'name' => 'Per day', 'data' => simulation.group_by_day(:created_at).sum(:avg_attendance_event) },
               # { 'name' => 'Annual  Attendance',
               #   'data' => simulation.group_by_day(:created_at).sum(:avg_attendance_annual_event) }]
    daily_data = simulation.where(created_at: @today)
    week_data = simulation.where(created_at: @week)
    month_data = simulation.where(created_at: @month)
    year_data = simulation.where(created_at: @year)

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
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => daily_data.group_by_day(:created_at).sum(:avg_attendance_event) },
               { 'name' => 'Annual  Attendance',
                 'data' => daily_data.group_by_day(:created_at).sum(:avg_attendance_annual_event) }]
      when 'Weekly'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => week_data.group_by_day(:created_at).sum(:avg_attendance_event) },
               { 'name' => 'Annual  Attendance',
                 'data' => week_data.group_by_day(:created_at).sum(:avg_attendance_annual_event) }]
      when 'Monthly'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => month_data.group_by_week(:created_at).sum(:avg_attendance_event) },
               { 'name' => 'Annual  Attendance',
                 'data' => month_data.group_by_week(:created_at).sum(:avg_attendance_annual_event) }]
      when 'Annually'
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => year_data.group_by_month(:created_at).sum(:avg_attendance_event) },
               { 'name' => 'Annual  Attendance',
                 'data' => year_data.group_by_month(:created_at).sum(:avg_attendance_annual_event) }]
      else
        data[:visitor_attendance] = [{'name' => 'Per day', 'data' => {'Daily' => daily_visitor, 'Weekly'=> week_visitor, 'Monthly' => month_visitor, 'Annualy' => year_visitor }},{'name' => 'Annual Attendance', 'data' => {'Daily' => daily_annual_visitor, 'Weekly'=> week_annual_visitor, 'Monthly' => month_annual_visitor, 'Annualy' => year_annual_visitor }}]
      end
    data[:daily_visitor_attendance] = daily_visitor
    data[:week_visitor_attendance] = week_visitor
    data[:month_visitor_attendance] = month_visitor
    data[:year_visitor_attendance] = month_visitor
  end

end