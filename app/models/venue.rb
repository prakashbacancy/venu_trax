class Venue < ApplicationRecord
  belongs_to :business
  has_one :simulation

  has_many :notes, as: :notable
  has_many :attachments, as: :attachable
  has_many :meetings, as: :meetingable, class_name: 'Meetings::Meeting', dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :revenue_sources, dependent: :destroy
  has_many :brands, dependent: :destroy

  default_scope { order(created_at: :desc) }

  PERMITTED_PARAM = %w[id domain name phone_no zip_code address city state description business_id no_of_employee].freeze

  def to_polymorphic
    "Venue:#{id}"
  end
end
