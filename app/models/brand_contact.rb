class BrandContact < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	PERMITTED_PARAM =  ["id", "email", "full_name", "phone_no", "job_title", "brand_id"] 
end
