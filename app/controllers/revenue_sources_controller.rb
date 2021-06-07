class RevenueSourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_venue, only: %i[new edit create update destroy]
  before_action :revenue_source, only: %i[show new edit create update]
  # before_action :find_venue_group, only: %i[show]
  # before_action :set_klass, only: %i[show new edit create update]
  # before_action :find_dynamic_fields, only: %i[new edit create update]
  # before_action :find_basic_group, only: %i[new edit create update]

  def create
    if revenue_source.update(revenue_source_params)
      flash[:success] = 'RevenueSource Successfully Added!'
      if params[:add_more].present?
        @revenue_sources_more = @venue.revenue_sources.new
      end
    else
      flash[:alert] = 'Error Occurred While Adding an RevenueSource!'
    end
    @brands = Brand.all
  end

  def update
    if revenue_source.update(revenue_source_params)
      flash[:success] = 'RevenueSource Successfully Updated!'
      if params[:add_more].present?
        @revenue_sources_more = @venue.revenue_sources.new
      end
    else
      flash[:alert] = 'Error Occurred While Updating an revenue_source!'
    end
    @brands = Brand.all
  end

  def destroy
    if revenue_source.destroy
      flash[:success] = 'RevenueSource Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting an RevenueSource!'
    end
    @brands = Brand.all
  end

  private

  def revenue_source
    @revenue_source ||= if params[:id].present?
                          RevenueSource.find(params[:id])
                        else
                          @venue.revenue_sources.new
                        end
  end

  def revenue_source_params
    # dynamic_params = Klass.revenue_source.fields.pluck(:name)
    # params.require(:revenue_source).permit(RevenueSource::PERMITTED_PARAM + dynamic_params)
    # NOTE: Better way to do it client side
    params[:revenue_source][:cpc] = params[:revenue_source][:cpc].gsub('$', '')
    params[:revenue_source][:cpm] = params[:revenue_source][:cpm].gsub('$', '')
    params[:revenue_source][:cpa] = params[:revenue_source][:cpa].gsub('$', '')
    params.require(:revenue_source).permit(RevenueSource::PERMITTED_PARAM)
  end

  def find_venue
    @venue = Venue.find(params[:venue_id])
  end

  def find_venue_group
    @venue = @revenue_source.venue
    @info_group = Group.find_by(name: 'RevenueSource Information')
  end

  def set_klass
    @klass = Klass.revenue_source
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
