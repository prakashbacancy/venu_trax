class VenueContact < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  PERMITTED_PARAM = %w[id full_name phone_no email job_title user_id venue_id].freeze
  JOB_TITLE = %w[Developer Manager Other].freeze
end