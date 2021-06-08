class Brand < ApplicationRecord
  has_many :event_brands, dependent: :destroy
  has_many :events, through: :event_brands
  has_many :revenue_sources, dependent: :destroy
  PERMITTED_PARAMS = ["id", "name", "created_at", "updated_at", "domain_name", "phone_number", "website_url", "city", "state", "zip_code", "no_of_employee", "annual_revenue", "brand_owner", "country", "street_address", "description", "venue_id"]
end
