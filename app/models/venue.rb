class Venue < ApplicationRecord
  belongs_to :business

  PERMITTED_PARAM = %w[id domain name phone_no zip_code address city state description business_id no_of_employee].freeze
end
