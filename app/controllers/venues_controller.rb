class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :venue, only: %i[show new edit]
  before_action :find_business, only: %i[show]
  before_action :find_notes, only: %i[show]
  before_action :find_meetings, only: %i[show]
  before_action :set_klass

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
    redirect_to redirect_url
  end

  def update
    if venue.update(venue_params)
      flash[:success] = 'Venue Successfully Updated!'
    else
      flash[:danger] = 'Error Occurred While Updating A Venue!'
    end
    redirect_to redirect_url
  end

  def destroy
    if venue.destroy
      flash[:success] = 'Venue Successfully Deleted!'
    else
      flash[:danger] = 'Error Occurred While Deleting A Venue!'
    end
    redirect_to redirect_url
  end

  def show
    @simulation = @venue.simulation
  end

  private

  def redirect_url
    "#{request.referrer}#venues-tab-body"
  end

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

  def find_business
    @business = @venue.business
  end

  def find_notes
    @notes = @venue.notes
  end

  def set_klass
    @klass = Klass.business
  end

  def find_meetings
    @meetings = @venue.meetings
  end
end
