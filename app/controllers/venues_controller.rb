class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :venue, only: %i[show new edit]

  def index
    @venues = Venue.all
  end

  def new
    venue.business_id = params[:business_id]
  end

  def create
    if venue.update(venue_params)
      flash[:success] = 'Venue Successfully Added!'
    else
      flash[:danger] = 'Error Occurred While Adding A Venue!'
    end
    redirect_to venues_path
  end

  def update
    if venue.update(venue_params)
      flash[:success] = 'Venue Successfully Updated!'
    else
      flash[:danger] = 'Error Occurred While Updating A Venue!'
    end
    redirect_to venues_path
  end

  def destroy
    if venue.destroy
      flash[:success] = 'Venue Successfully Deleted!'
    else
      flash[:danger] = 'Error Occurred While Deleting A Venue!'
    end
    redirect_to venues_path
  end

  private

  def venue
    @venue ||= if params[:id].present?
                 Venue.find(params[:id])
               else
                 Venue.new
               end
  end

  def venue_params
    params.require(:venue).permit(Venue::PERMITTED_PARAM)
  end
end
