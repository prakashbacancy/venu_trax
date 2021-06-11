class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :venue, only: %i[show new edit create update destroy]
  before_action :find_business, only: %i[new edit create update destroy]
  before_action :set_business_notes_brands_contacts, only: %i[show]
  before_action :find_meetings_events, only: %i[show]
  before_action :set_klass
  before_action :find_dynamic_fields, only: %i[new edit create update]
  before_action :find_basic_group, only: %i[show new edit create update]

  def index
    @venues = Venue.all
  end

  def new
    venue.business_id = params[:business_id]
  end

  def create
    if venue.update(venue_params)
      venues
      set_new_venue if params[:add_more].present?
      flash[:success] = 'Venue Successfully Added!'
    else
      flash[:alert] = venue.errors.full_messages.join(', ')
    end
  end

  def update
    if venue.update(venue_params)
      venues
      set_new_venue if params[:add_more].present?
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

  def set_business_notes_brands_contacts
    @business = @venue.business
    @notes = @venue.notes
    @brands = Brand.all
    @venue_contacts = @venue.venue_contacts
  end

  def set_klass
    @klass = Klass.business
    @venue_klass = Klass.venue
  end

  def find_meetings_events
    @meetings = if current_user.try(:contact) == 'venue_contact'
                  meeting_ids = @venue.meeting_ids
                  local_meeting_ids = current_user.attendees.where(meeting_id: meeting_ids).pluck(:meeting_id)
                  Meetings::Meeting.where(id: local_meeting_ids)
                else
                  @venue.meetings
                end
    @events = @venue.events
  end

  def find_dynamic_fields
    fields = @venue_klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end

  def find_basic_group
    @info_group = Group.venue_basic
    @group = if params[:group_id].present?
               group = Group.find_by(id: params[:group_id])
               @root_group_id = group.root.id
               group
             else
               Group.venue_basic
             end
  end
end
