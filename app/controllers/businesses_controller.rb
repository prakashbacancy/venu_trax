class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :business, only: %i[show new edit]
  before_action :find_venues, only: %i[show]
  before_action :find_notes, only: %i[show]

  def index
    @businesses = Business.all
  end

  def create
    if business.update(business_params)
      flash[:success] = 'Business Successfully Added!'
    else
      flash[:danger] = 'Error Occurred While Adding A Business!'
    end
    redirect_to businesses_path
  end

  def update
    if business.update(business_params)
      flash[:success] = 'business Successfully Updated!'
    else
      flash[:danger] = 'Error Occurred While Updating A business!'
    end
    redirect_to businesses_path
  end

  def destroy
    if business.destroy
      flash[:success] = 'Business Successfully Deleted!'
    else
      flash[:danger] = 'Error Occurred While Deleting A Business!'
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
    params.require(:business).permit(Business::PERMITTED_PARAM)
  end

  def find_venues
    @venues = @business.venues
  end

  def find_notes
    @notes = @business.notes
  end
end
