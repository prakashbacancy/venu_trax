class BrandContactsController < ApplicationController
	before_action :authenticate_user!
	before_action :load_brand, only: %i[new show create edit update destroy]
  before_action :brand_contact, only: %i[show edit update destroy]

  def new
  	@brand_contact = BrandContact.new
  end

  def index
    @brand_contacts = @brand.brand_contacts
  end

  def create
    @brand_contact = BrandContact.new(contacts_params)
    if @brand_contact.save
      set_new_brand_contacts if params[:add_more].present?
      flash[:success] = 'Brand Contact Successfully added'
    else
      flash[:alert] = 'Can not add a Note'
    end
    @brand_contacts = @brand.brand_contacts
  end

  def update
    if brand_contact.update(contacts_params)
      set_new_brand_contacts if params[:add_more].present?
      flash[:success] = 'Brand Contact updated'
    else
      flash[:alert] = 'Can not update a Brand Contact'
    end
    @brand_contacts = @brand.brand_contacts
  end

  def destroy
    if brand_contact.destroy
      flash[:success] = 'Brand Contact Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting A Brand Contact!'
    end
    @brand_contacts = @brand.brand_contacts
  end

  private

  def brand_contact
    @brand_contact ||= if params[:id].present?
                BrandContact.find(params[:id])
              else
                BrandContact.new
              end
  end

  def set_new_brand_contacts
    @brand_contact_more = if @brand
               @brand.brand_contacts.new
             else
               BrandContact.new
             end
  end

  def load_brand
  	@brand = Brand.find_by_id(params[:brand_id])
  end

  def contacts_params
    params.require(:brand_contact).permit(BrandContact::PERMITTED_PARAM)
  end
end
