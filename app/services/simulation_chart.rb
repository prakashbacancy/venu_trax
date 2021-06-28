class SimulationChart
	def initialize(params, simulation)
		@params = params
    @simulation = simulation
    @color_option = {"fill"=>false, "backgroundColor"=> ["#01d0ff", "#f95059", "#f99c4f", "#4941e9"],
    "borderColor"=>["#01d0ff", "#f95059", "#f99c4f", "#4941e9", "rgba(54, 162, 235)", "rgba(153, 102, 255)", "rgba(201, 203, 207)"],
    "borderWidth"=>2}
    @day_color_option = { "fill"=>false, "backgroundColor"=> ["#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff","#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff"],
    "borderColor"=> ["#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff","#01d0ff", "#01d0ff", "#01d0ff", "#01d0ff"],
    "borderWidth"=>2 }
    @week_color_option = { "fill"=>false, "backgroundColor"=> ["#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059","#f95059", "#f95059", "#f95059", "#f95059"],
    "borderColor"=> ["#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059", "#f95059","#f95059", "#f95059", "#f95059", "#f95059"],
    "borderWidth"=>2 }
    @month_color_option = { "fill"=>false, "backgroundColor"=> ["#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f","#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f"],
    "borderColor"=> ["#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f","#f99c4f", "#f99c4f", "#f99c4f", "#f99c4f"],
    "borderWidth"=>2 }
    @annualy_color_option = { "fill"=>false, "backgroundColor"=> ["#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9","#4941e9", "#4941e9", "#4941e9", "#4941e9"],
    "borderColor"=> ["#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9", "#4941e9","#4941e9", "#4941e9", "#4941e9", "#4941e9"],
    "borderWidth"=>2 }
	end

	def calculation
		data = {}
		set_date_filter
		simulation =  @simulation

    daily_data = simulation.where(updated_at: @today)
    week_data = simulation.where(updated_at: @week)
    month_data = simulation.where(updated_at: @month)
    year_data = simulation.where(updated_at: @year)
		seating_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
    vistior_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
    wifilp_login_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)
    lp_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    user_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    cpm_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    cpa_impression(@params, simulation, data, daily_data, week_data, month_data, year_data)
    wifi_revenue_chart(@params, simulation, data, daily_data, week_data, month_data, year_data)		
    page_view_fee(@params, simulation, data, daily_data, week_data, month_data, year_data)   
    
    data[:input_annual_att_per] = simulation.pluck(:annual_attendance_per).join(",")
    data[:input_visitor_wifi_login] = simulation.pluck(:visitor_wifi_login).join(",")
    data[:input_cost_lp_impression] = simulation.pluck(:cost_lp_impression).join(",")
    data[:input_event_usage_impression] = simulation.pluck(:event_usage_impression).join(",")
    data[:input_cpm_impression_cost] = simulation.pluck(:cpm_impression_cost).join(",")
    data[:input_cpa_impression_cost] = simulation.pluck(:cpa_impression_cost).join(",")
    data[:input_contract_month] = simulation.pluck(:contract_month).join(",")
    data[:page_view_fee] = simulation.pluck(:page_view_fee).join(",")
    
    
    data
	end

	def set_date_filter
  	@today = Date.today.beginning_of_day..Date.today.end_of_day
    @week = Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day
    @month = Date.today.beginning_of_month.beginning_of_day..Date.today.end_of_month.end_of_day
    @year = Date.today.beginning_of_year.beginning_of_day..Date.today.end_of_year.end_of_day
  end

  def page_view_fee(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_page_view_fee = daily_data.sum(:page_view_fee)
    day_page_view_fee = daily_data.sum(:day_page_view_fee)
    week_page_view_fee = week_data.sum(:week_page_view_fee)
    month_page_view_fee = month_data.sum(:month_page_view_fee)
    year_page_view_fee = year_data.sum(:annual_page_view_fee)

     @date_range = case params[:option]
      when 'Today'
        today_data = chart_data(daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:page_view_fee))
        data[:page_view_impression] = [{ data: today_data, library: @day_color_option }]
      when 'Weekly'
        data[:page_view_impression] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:week_page_view_fee).collect{|k,v| [k.to_s + '_', v]}.to_h), library: @week_color_option}]
      when 'Monthly'
        data[:page_view_impression] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:month_page_view_fee)), library: @month_color_option}]
      when 'Annually'
        data[:page_view_impression] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:annual_page_view_fee)), library: @annualy_color_option}]
      else
        data[:page_view_impression] =  [{"data"=>[["Daily", day_page_view_fee], ["Weekly", week_page_view_fee], ["Monthly", month_page_view_fee], ["Annually", year_page_view_fee]],
      "library"=> @color_option }]
        #{'Daily' => daily_page_view_fee, 'Weekly'=> week_page_view_fee, 'Monthly' => month_page_view_fee, 'Annually' => year_page_view_fee}
      end

    data[:daily_page_view_fee] = daily_page_view_fee
    data[:day_page_view_fee] = day_page_view_fee
    data[:week_page_view_fee] = week_page_view_fee
    data[:month_page_view_fee] = month_page_view_fee
    data[:year_page_view_fee] = year_page_view_fee

    day_total_wifi_lp = daily_data.sum(:total_wifi_lp_single)
    week_total_wifi_lp = year_data.sum(:total_wifi_lp_week)
    month_total_wifi_lp = month_data.sum(:total_wifi_lp_month)
    year_total_wifi_lp = week_data.sum(:total_wifi_lp_annual)

    data[:total_wifi_lp_single] = day_total_wifi_lp
    data[:total_wifi_lp_week] = week_total_wifi_lp
    data[:total_wifi_lp_month] = month_total_wifi_lp
    data[:total_wifi_lp_annual] = year_total_wifi_lp

  end

  def seating_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily = daily_data.sum(:daily_seating_capacity)
    day_data = daily_data.sum(:day_seating_capacity)
    week = week_data.sum(:week_seating_capacity)
    month = month_data.sum(:month_seating_capacity)
    year = year_data.sum(:annual_seating_capacity)
    @date_range = case params[:option]
    when 'Today'
      today_data = chart_data(daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:daily_seating_capacity))
      data[:seating_capacity] = [{ data: today_data, library: @day_color_option }]
    when 'Weekly'
      data[:seating_capacity] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:week_seating_capacity)), library: @week_color_option}]
    when 'Monthly'
      data[:seating_capacity] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:month_seating_capacity)), library: @month_color_option}]
    when 'Annually'
      data[:seating_capacity] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:annual_seating_capacity)), library: @annualy_color_option}]
    when 'Date Range'
    data[:seating_capacity] = {"#{params[:start_date]} To #{params[:end_date]}" => 15000}
    else
      data[:seating_capacity] = [{"data"=>[["Daily", daily], ["Weekly", week], ["Monthly", month], ["Annually", year]],
      "library"=> @color_option}]
      #{'Daily' => daily, 'Weekly'=> week, 'Monthly' => month, 'Annually' => year }
    end
   data[:daily_seating_capacity] = daily
   data[:day_seating_capacity] = day_data
   data[:week_seating_capacity] = week
   data[:month_seating_capacity] = month
   data[:year_seating_capacity] = year

  end
  def vistior_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_visitor = daily_data.sum(:avg_attendance_event)
    day_visitor = daily_data.sum(:day_attendance_event)
    week_visitor = week_data.sum(:week_attendance_event)
    month_visitor = month_data.sum(:month_attendance_event)
    year_visitor = year_data.sum(:avg_attendance_annual_event)
      @date_range = case params[:option]
      when 'Today'
        today_data = chart_data(daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:avg_attendance_event))
        data[:visitor_attendance] = [{ data: today_data, library: @day_color_option }]
      when 'Weekly'
        data[:visitor_attendance] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:week_attendance_event).collect{|k,v| [k.to_s + '_', v]}.to_h), library: @week_color_option}]
      when 'Monthly'
        data[:visitor_attendance] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:month_attendance_event)), library: @month_color_option}]
      when 'Annually'
        data[:visitor_attendance] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:avg_attendance_annual_event)), library: @annualy_color_option}]
      else
        data[:visitor_attendance] =  [{"data"=>[["Daily", daily_visitor], ["Weekly", week_visitor], ["Monthly", month_visitor], ["Annually", year_visitor]],
      "library"=> @color_option }]
        #{'Daily' => daily_visitor, 'Weekly'=> week_visitor, 'Monthly' => month_visitor, 'Annually' => year_visitor}
      end
    data[:daily_visitor_attendance] = daily_visitor
    data[:day_visitor_attendance] = day_visitor
    data[:week_visitor_attendance] = week_visitor
    data[:month_visitor_attendance] = month_visitor
    data[:year_visitor_attendance] = year_visitor
  end

  def wifilp_login_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_wifi_lp_login = daily_data.sum(:wifi_lp_per_day_login)
    day_wifi_lp_login = daily_data.sum(:wifi_lp_day_login)
    week_wifi_lp_login = week_data.sum(:wifi_lp_week_login)
    month_wifi_lp_login = month_data.sum(:wifi_lp_month_login)
    year_wifi_lp_login = year_data.sum(:wifi_lp_annual_login)

    @date_range = case params[:option]
      when 'Today'
        today_data = chart_data(daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:wifi_lp_per_day_login))
        data[:wifi_lp_login] = [{ data: today_data, library: @day_color_option }]
      when 'Weekly'
        data[:wifi_lp_login] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:wifi_lp_week_login)), library: @week_color_option}]
      when 'Monthly'
        data[:wifi_lp_login] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:wifi_lp_month_login)), library: @month_color_option}]
      when 'Annually'
        data[:wifi_lp_login] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:wifi_lp_annual_login)), library: @annualy_color_option}]
      else
        data[:wifi_lp_login] = [{"data"=>[["Daily", daily_wifi_lp_login], ["Weekly", week_wifi_lp_login], ["Monthly", month_wifi_lp_login], ["Annually", year_wifi_lp_login]],
      "library"=> @color_option}]
        #data[:wifi_lp_login] =  {'Daily' => daily_wifi_lp_login, 'Weekly'=> week_wifi_lp_login, 'Monthly' => month_wifi_lp_login, 'Annually' => year_wifi_lp_login }
      end
    data[:daily_wifi_lp_login] = daily_wifi_lp_login
    data[:wifi_lp_day_login] = day_wifi_lp_login
    data[:week_wifi_lp_login] = week_wifi_lp_login
    data[:month_wifi_lp_login] = month_wifi_lp_login
    data[:year_wifi_lp_login] = year_wifi_lp_login
  end

  def lp_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_lp_impression = daily_data.sum(:lp_rev_per_day_total)
    day_lp_impression = daily_data.sum(:lp_rev_day_total)
    
    week_lp_impression = week_data.sum(:lp_rev_week_total)
    month_lp_impression = month_data.sum(:lp_rev_month_total)
    year_lp_impression = year_data.sum(:lp_rev_annual_total)

    @date_range = case params[:option]
      when 'Today'
        today_data = chart_data(daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:lp_rev_per_day_total))
        data[:lp_impression] = [{ data: today_data, library: @day_color_option }]
      when 'Weekly'
        data[:lp_impression] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:lp_rev_week_total)), library: @week_color_option}]
      when 'Monthly'
        data[:lp_impression] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:lp_rev_month_total)), library: @month_color_option}]
      when 'Annually'
        data[:lp_impression] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:lp_rev_annual_total)), library: @annualy_color_option}]
      else
        data[:lp_impression] = [{"data"=>[["Daily", daily_lp_impression], ["Weekly", week_lp_impression], ["Monthly", month_lp_impression], ["Annually", year_lp_impression]],
      "library"=> @color_option}]
        #data[:lp_impression] = {'Daily' => daily_lp_impression, 'Weekly'=> week_lp_impression, 'Monthly' => month_lp_impression, 'Annually' => year_lp_impression }
      end
    data[:daily_lp_impression] = daily_lp_impression
    data[:day_lp_impression] = day_lp_impression

    data[:week_lp_impression] = week_lp_impression
    data[:month_lp_impression] = month_lp_impression
    data[:year_lp_impression] = year_lp_impression
  end

  def user_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_user_impression = daily_data.sum(:user_impression_per_day)
    day_user_impression = week_data.sum(:user_impression_day)

    week_user_impression = week_data.sum(:user_impression_week)
    month_user_impression = month_data.sum(:user_impression_month)
    year_user_impression = year_data.sum(:user_impression_annual)

    @date_range = case params[:option]
      when 'Today'
        today_data = chart_data(daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:user_impression_per_day))
        data[:user_impression] = [{ data: today_data, library: @day_color_option }]
      when 'Weekly'
        data[:user_impression] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:user_impression_per_day)), library: @week_color_option}]
      when 'Monthly'
        data[:user_impression] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:user_impression_per_day)), library: @month_color_option}]
      when 'Annually'
        data[:user_impression] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:user_impression_per_day)), library: @annualy_color_option}]
      else
        data[:user_impression] = [{"data"=>[["Daily", daily_user_impression], ["Weekly", week_user_impression], ["Monthly", month_user_impression], ["Annually", year_user_impression]],
      "library"=> @color_option }]
        #{'Daily' => daily_user_impression, 'Weekly'=> week_user_impression, 'Monthly' => month_user_impression, 'Annually' => year_user_impression }
      end
    data[:daily_user_impression] = daily_user_impression
    data[:day_user_impression] = day_user_impression
    data[:week_user_impression] = week_user_impression
    data[:month_user_impression] = month_user_impression
    data[:year_user_impression] = year_user_impression
  end

  def cpm_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_cpm_impression = daily_data.sum(:cpm_impression_per_day)
    day_cpm_impression = daily_data.sum(:cpm_impression_day)

    week_cpm_impression = week_data.sum(:cpm_impression_week)
    month_cpm_impression = month_data.sum(:cpm_impression_month)
    year_cpm_impression = year_data.sum(:cpm_impression_annual)

    @date_range = case params[:option]
      when 'Today'
        today_data = daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:cpm_impression_per_day)
        data[:cpm_impression] = [{ data: today_data, library: @day_color_option }]
      when 'Weekly'
        data[:cpm_impression] = [{ data: chart_data(week_data.group_by_day(:updated_at).sum(:cpm_impression_week)), library: @week_color_option}]
      when 'Monthly'
        data[:cpm_impression] = [{ data: chart_data(month_data.group_by_week(:updated_at, week_start: :monday).sum(:cpm_impression_month)), library: @month_color_option}]
      when 'Annually'
        data[:cpm_impression] = [{ data: chart_data(year_data.group_by_month(:updated_at).sum(:cpm_impression_annual)), library: @annualy_color_option}]
      else
        data[:cpm_impression] = [{"data"=>[["Daily", daily_cpm_impression], ["Weekly", week_cpm_impression], ["Monthly", month_cpm_impression], ["Annually", year_cpm_impression]],
      "library"=> @color_option}]

        #{'Daily' => daily_cpm_impression, 'Weekly'=> week_cpm_impression, 'Monthly' => month_cpm_impression, 'Annually' => year_cpm_impression }
      end
    data[:daily_cpm_impression] = daily_cpm_impression
    data[:day_cpm_impression] = day_cpm_impression
    data[:week_cpm_impression] = week_cpm_impression
    data[:month_cpm_impression] = month_cpm_impression
    data[:year_cpm_impression] = year_cpm_impression
  end

  def cpa_impression(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily_cpa_impression = daily_data.sum(:cpa_per_day_login)
    day_cpa_impression = daily_data.sum(:cpa_day_login)
    week_cpa_impression = week_data.sum(:cpa_week_login)
    month_cpa_impression = month_data.sum(:cpa_month_login)
    year_cpa_impression = year_data.sum(:cpa_annual_login)

    @date_range = case params[:option]
      when 'Today'
        data[:cpa_impression] = daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:cpa_day_login)
      when 'Weekly'
        data[:cpa_impression] = week_data.group_by_day(:updated_at).sum(:cpa_week_login)
      when 'Monthly'
        data[:cpa_impression] = month_data.group_by_week(:updated_at, week_start: :monday).sum(:cpa_month_login)
      when 'Annually'
        data[:cpa_impression] = year_data.group_by_month(:updated_at).sum(:cpa_annual_login)
      else
        data[:cpa_impression] = {'Daily' => daily_cpa_impression, 'Weekly'=> week_cpa_impression, 'Monthly' => month_cpa_impression, 'Annually' => year_cpa_impression }
      end
    data[:daily_cpa_impression] = daily_cpa_impression
    data[:day_cpa_impression] = day_cpa_impression
    data[:week_cpa_impression] = week_cpa_impression
    data[:month_cpa_impression] = month_cpa_impression
    data[:year_cpa_impression] = year_cpa_impression
  end

  def wifi_revenue_chart(params, simulation, data, daily_data, week_data, month_data, year_data)
    daily = daily_data.sum(:wifi_annual_day_total)
    week = week_data.sum(:wifi_annual_week_total)
    month = month_data.sum(:wifi_annual_month_total)
    year = year_data.sum(:wifi_annual_total)
     @date_range = case params[:option]
      when 'Today'
        data[:wifi_revenue] =  daily_data.group_by_hour_of_day(:updated_at, format: "%-l %P").sum(:wifi_annual_day_total)
      when 'Weekly'
        data[:wifi_revenue] = week_data.group_by_day(:updated_at).sum(:wifi_annual_week_total).collect{|k,v| [k.to_s + '_', v]}.to_h
      when 'Monthly'
        data[:wifi_revenue] = month_data.group_by_week(:updated_at, week_start: :monday).sum(:wifi_annual_month_total)
      when 'Annually'
        data[:wifi_revenue] = year_data.group_by_month(:updated_at).sum(:wifi_annual_total)
      else
        data[:wifi_revenue] = {'Daily' => daily, 'Weekly'=> week, 'Monthly' => month, 'Annually' => year }
      end
    data[:daily_wifi_revenue] = daily
    data[:week_wifi_revenue] = week
    data[:month_wifi_revenue] = month
    data[:year_wifi_revenue] = year
  end
  def chart_data(data)
    chart_type_datasets = []
    data.each do |key, value|
      dataset = {}
      chart_type_datasets << [key, value]
    end
    chart_type_datasets
  end
end
