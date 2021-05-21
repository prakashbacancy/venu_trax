class Venue < ApplicationRecord
  belongs_to :business

  has_many :notes, as: :notable

  default_scope { order(created_at: :desc) }

  PERMITTED_PARAM = %w[id domain name phone_no zip_code address city state description business_id no_of_employee].freeze
end
