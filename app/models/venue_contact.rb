class VenueContact < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  has_one_attached :profile_pic, dependent: :destroy

  PERMITTED_PARAM = %w[id full_name phone_no email job_title user_id venue_id profile_pic].freeze
  JOB_TITLE = %w[Developer Manager Other].freeze
end