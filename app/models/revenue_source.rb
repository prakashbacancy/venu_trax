class RevenueSource < ApplicationRecord
  belongs_to :venue
  belongs_to :brand

  PERMITTED_PARAM = %w[id name cpc cpm cpa description brand_id venue_id event_id].freeze
end
