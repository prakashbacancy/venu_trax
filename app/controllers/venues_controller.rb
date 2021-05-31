class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :venue, only: %i[show new edit create update destroy]
  before_action :find_business, only: %i[new edit create update destroy]
  before_action :set_business, only: %i[show]
  before_action :set_notes, only: %i[show]
  before_action :find_meetings, only: %i[show]
  before_action :set_klass
  before_action :find_dynamic_fields, only: %i[new edit create update]

  def index
    @venues = Venue.all
  end

  def new
    venue.business_id = params[:business_id]
  end

  def create
    if venue.update(venue_params)
      venues
      set_new_venue
      flash[:success] = 'Venue Successfully Added!'
    else
      flash[:alert] = venue.errors.full_messages.join(', ')
    end
  end

  def update
    if venue.update(venue_params)
      venues
      set_new_venue
      flash[:success] = 'Venue Successfully Updated!'
    else
      flash[:alert] = venue.errors.full_messages.join(', ')
    end
  end

  def destroy
    if venue.destroy
      flash[:success] = 'Venue Successfully Deleted!'
    else
      flash[:alert] = venue.errors.full_messages.join(', ')
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

  def venues
    @venues = if params[:business_id]
                @venue.business.venues
              else
                Venue.all
              end
  end

  # Set new venue object for `Add More`
  def set_new_venue
    @venue = if @business
               @business.venues.new
             else
               Venue.new
             end
  end

  def venue_params
    dynamic_params = Klass.venue.fields.pluck(:name)
    params.require(:venue).permit(Venue::PERMITTED_PARAM + dynamic_params)
  end

  def find_business
    @business = Business.find_by(id: params[:business_id])
  end

  def set_business
    @business = @venue.business
  end

  def set_notes
    @notes = @venue.notes
  end

  def set_klass
    @klass = Klass.business
  end

  def find_meetings
    @meetings = @venue.meetings
  end

  def find_dynamic_fields
    fields = @klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end
end
