class Business < ApplicationRecord
	PERMITTED_PARAM = ["id", "name", "industry", "business_type", "phone_no", "zip_code", "address", "city", "state", "no_of_employee", "annual_revenue", "description"]
end
