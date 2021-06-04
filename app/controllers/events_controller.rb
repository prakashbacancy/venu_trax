class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_venue, only: %i[new edit create update destroy]
  before_action :event, only: %i[show new edit create update]
  before_action :find_venue_group, only: %i[show]
  before_action :set_klass, only: %i[show new edit create update]
  # before_action :find_dynamic_fields, only: %i[new edit create update]
  # before_action :find_basic_group, only: %i[new edit create update]

  def index
    @events = Event.all
  end

  def new
    @event.event_brands.build
  end

  def create
    if event.update(event_params)
      flash[:success] = 'Event Successfully Added!'
      (@event = @venue.events.new) if params[:add_more].present?
    else
      flash[:alert] = 'Error Occurred While Adding an Event!'
    end
    @events = @venue.events
  end

  def edit
    @event.event_brands.build if @event.event_brands.blank?
  end

  def update
    if event.update(event_params)
      flash[:success] = 'Event Successfully Updated!'
      (@event = @venue.events.new) if params[:add_more].present?
    else
      flash[:alert] = 'Error Occurred While Updating an event!'
    end
    @events = @venue.events
  end

  def destroy
    if event.destroy
      flash[:success] = 'Event Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting an Event!'
    end
    @events = @venue.events
  end

  private

  def event
    @event ||= if params[:id].present?
                 Event.find(params[:id])
               else
                 @venue.events.new
               end
  end

  def event_params
    # dynamic_params = Klass.event.fields.pluck(:name)
    # params.require(:event).permit(Event::PERMITTED_PARAM + dynamic_params)
    params[:event][:start_date] = DateTime.strptime(params[:event][:start_date], '%m/%d/%Y') if params[:event][:start_date].present?
    params[:event][:end_date] = DateTime.strptime(params[:event][:end_date], '%m/%d/%Y') if params[:event][:end_date].present?
    params.require(:event).permit(Event::PERMITTED_PARAM)
  end

  def find_venue
    @venue = Venue.find(params[:venue_id])
  end

  def find_venue_group
    @venue = @event.venue
    @info_group = Group.find_by(name: 'Event Information')
  end

  def set_klass
    @klass = Klass.event
  end

  def find_dynamic_fields
    fields = @klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end

  def find_basic_group
    @info_group = Group.event_basic
    @group = if params[:group_id].present?
               group = Group.find_by(id: params[:group_id])
               @root_group_id = group.root.id
               group
             else
               Group.event_basic
             end
  end
end
