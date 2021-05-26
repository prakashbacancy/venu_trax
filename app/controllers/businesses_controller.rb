class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :business, only: %i[show new edit create update]
  before_action :find_venues, only: %i[show]
  before_action :find_notes, only: %i[show]
  before_action :set_klass, only: %i[show new edit create update]
  before_action :find_dynamic_fields, only: %i[new edit create update]

  def index
    @businesses = Business.all
  end

  def create
    if business.update(business_params)
      flash[:success] = 'Business Successfully Added!'
      @business = Business.new
    else
      flash[:alert] = 'Error Occurred While Adding A Business!'
    end
    @businesses = Business.all
  end

  def update
    if business.update(business_params)
      flash[:success] = 'Business Successfully Updated!'
      @business = Business.new
    else
      flash[:alert] = 'Error Occurred While Updating A business!'
    end
    @businesses = Business.all
  end

  def destroy
    if business.destroy
      flash[:success] = 'Business Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting A Business!'
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

  def find_venues
    @venues = @business.venues
  end

  def find_notes
    @notes = @business.notes.recent
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
end
