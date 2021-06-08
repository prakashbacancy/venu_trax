class BrandsController < ApplicationController
  before_action :brand, only: %i[show edit update]
  before_action :load_brands, only: %i[show edit update]

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
        @brand_more = @venue.brands.new
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
        @brand_more = @venue.brands.new
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
  	params.require(:brand).permit(Brand::PERMITTED_PARAMS)
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

  def load_brands
  	@brands = Brand.all
  end

  # Set new venue object for `Add More`
  def set_new_venue
    @brand = Brand.new
  end
end
