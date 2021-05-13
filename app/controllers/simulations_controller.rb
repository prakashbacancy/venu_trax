class SimulationsController < ApplicationController
  before_action :authenticate_user!

  def index
    set_date_filter
    @simulations = SimulationChart.new(params).calculation
    # @simulations = Simulation.where(created_at: @date_range)

    # @visitor_attendance, @wifi_login, @cpm_lpm, @user_impression, @lp_impression = visitor_attendance(@simulations)
  end

  def new
    simulation
  end

  def edit
    simulation
  end

  def create
    if simulation.update(simulation_params)
      flash[:success] = 'Simulation Successfully Added!'
    else
      flash[:danger] = 'Error Occurred While Adding A Simulation!'
    end
    redirect_to simulations_path
  end

  def update
    if simulation.update(simulation_params)
      flash[:success] = 'Simulation Successfully Updated!'
    else
      flash[:danger] = 'Error Occurred While Updating A Simulation!'
    end
    redirect_to simulations_path
  end

  def destroy
    if simulation.destroy
      flash[:success] = 'Simulation Successfully Deleted!'
    else
      flash[:danger] = 'Error Occurred While Deleting A Simulation!'
    end
    redirect_to simulations_path
  end

  private

  def simulation
    @simulation ||= if params[:id].present?
                      Simulation.find(params[:id])
                    else
                      Simulation.new
                    end
  end

  def simulation_params
    params.require(:simulation).permit(Simulation::PERMITTED_PARAM)
  end

  def set_date_filter
    @date_range = case params[:option]
                  when 'Today'
                    Date.today.beginning_of_day..Date.today.end_of_day
                  when 'Weekly'
                    Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day
                  when 'Monthly'
                    Date.today.beginning_of_month.beginning_of_day..Date.today.end_of_month.end_of_day
                  when 'Annually'
                    Date.today.beginning_of_year.beginning_of_day..Date.today.end_of_year.end_of_day
                  else
                    Date.today.beginning_of_day..Date.today.end_of_day
                  end
  end

  def visitor_attendance(data)
    visitor = [{ 'name' => 'Per day', 'data' => data.group_by_day(:created_at).sum(:avg_attendance_event) },
               { 'name' => 'Annual  Attendance',
                 'data' => data.group_by_day(:created_at).sum(:avg_attendance_annual_event) }]
    wifi_login = [{ 'name' => 'Per day', 'data' => data.group_by_day(:created_at).sum(:wifi_lp_per_day_login) },
                  { 'name' => 'Annual', 'data' => data.group_by_day(:created_at).sum(:wifi_lp_annual_login) }]
    lp_impression = [{ 'name' => 'Per day', 'data' => data.group_by_day(:created_at).sum(:lp_rev_per_day_total) },
                     { 'name' => 'Annual', 'data' => data.group_by_day(:created_at).sum(:lp_rev_annual_total) }]
    cpm_lp = [{ 'name' => 'Per day', 'data' => data.group_by_day(:created_at).sum(:cpm_impression_per_day) },
              { 'name' => 'Annual', 'data' => data.group_by_day(:created_at).sum(:cpm_impression_annual) }]
    user_impression = [{ 'name' => 'Per day', 'data' => data.group_by_day(:created_at).sum(:user_impression_per_day) },
                       { 'name' => 'Annual', 'data' => data.group_by_day(:created_at).sum(:user_impression_annual) }]
    [visitor, wifi_login, cpm_lp, user_impression, lp_impression]
  end
end
