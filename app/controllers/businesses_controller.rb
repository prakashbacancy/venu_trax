class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :business, only: %i[show new edit create update]
  before_action :find_venues_notes_group, only: %i[show]
  before_action :set_klass, only: %i[show new edit create update]
  before_action :find_dynamic_fields, only: %i[new edit create update]
  before_action :find_basic_group, only: %i[new edit create update]

  def index
    @businesses = Business.all
  end

  def create
    if business.update(business_params)
      flash[:success] = 'Business Successfully Added!'
      @business = Business.new
    else
      flash[:alert] = @business.errors.full_messages.join(",")
    end
    @businesses = Business.all
  end

  def update
    if business.update(business_params)
      flash[:success] = 'Business Successfully Updated!'
      (@business = Business.new) if params[:add_more].present?
    else
      flash[:alert] = business.errors.full_messages.join(",")
    end
    @businesses = Business.all
  end

  def destroy
    if business.destroy
      flash[:success] = 'Business Successfully Deleted!'
    else
      flash[:alert] = business.errors.full_messages.join(",")
    end
    redirect_to businesses_path
  end

  private

  def business
    @business ||= if params[:id].present?
                    Business.find(params[:id])
                  else
                    Business.new
                  end
  end

  def business_params
    dynamic_params = Klass.business.fields.pluck(:name)
    params.require(:business).permit(Business::PERMITTED_PARAM + dynamic_params)
  end

  def find_venues_notes_group
    @venues = @business.venues
    @notes = @business.notes.recent
    @info_group = Group.find_by(name: 'Business Information')
  end

  def set_klass
    @klass = Klass.business
  end

  def find_dynamic_fields
    fields = @klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end

  def find_basic_group
    @info_group = Group.business_basic
    @group = if params[:group_id].present?
               group = Group.find_by(id: params[:group_id])
               @root_group_id = group.root.id
               group
             else
               Group.business_basic
             end
  end
end
