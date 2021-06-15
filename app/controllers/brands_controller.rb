class BrandsController < ApplicationController
  before_action :brand, only: %i[show edit update]
  before_action :load_brands, only: %i[create update]
  before_action :load_data, only: %i[show]
  before_action :set_klass
  before_action :find_dynamic_fields, only: %i[new edit create update]
  before_action :find_basic_group, only: %i[show new edit create update]

	def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
  	@brand = Brand.new(brand_params)
    if @brand.save
      if params[:add_more].present?
        @brand_more = Brand.new
      end
      flash[:success] = 'Brand Successfully Added!'
    else
      flash[:alert] = brand.errors.full_messages.join(', ')
    end
  end

  def edit
  end

  def update
    if brand.update(brand_params)
      if params[:add_more].present?
        @brand_more = Brand.new
      end
    else
      flash[:alert] = brand.errors.full_messages.join(', ')
    end
  end

  def destroy
    if brand.destroy
      flash[:success] = 'Brand Successfully Deleted!'
    else
      flash[:alert] = venue.errors.full_messages.join(', ')
    end
  end

  def show
  end

  private

  def brand_params
    dynamic_params = Klass.brand.fields.pluck(:name)
    params.require(:brand).permit(Brand::PERMITTED_PARAMS + dynamic_params)
  end

  def redirect_url
    "#{request.referrer}#venues-tab-body"
  end

  def brand
    @brand ||= if params[:id].present?
                Brand.find(params[:id])
               else
                Brand.new
               end
  end

  def load_data
    @notes = @brand.notes
    @brand_contacts = @brand.brand_contacts

  end

  def load_brands
  	@brands = Brand.all
  end

  # Set new venue object for `Add More`
  def set_new_venue
    @brand = Brand.new
  end

  def set_klass
    @klass = Klass.brand
  end

  def find_dynamic_fields
    fields = @klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end

  def find_basic_group
    @info_group = Group.brand_basic
    @group = if params[:group_id].present?
               group = Group.find_by(id: params[:group_id])
               @root_group_id = group.root.id
               group
             else
               Group.brand_basic
             end
  end
end
