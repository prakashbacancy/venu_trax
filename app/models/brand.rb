class Brand < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  has_many :event_brands, dependent: :destroy
  has_many :brand_contacts, dependent: :destroy
  has_many :notes, as: :notable
  has_many :events, through: :event_brands
  has_many :revenue_sources, dependent: :destroy
  has_one_attached :brand_pic, dependent: :destroy
  PERMITTED_PARAMS = ["id", "name", "created_at", "updated_at", "domain_name", "phone_number", "website_url", "city", "state", "zip_code", "no_of_employee", "annual_revenue", "brand_owner", "country", "street_address", "description", "venue_id", "brand_pic"]
end
