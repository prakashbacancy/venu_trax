class Attachment < ApplicationRecord
	belongs_to :venue
  belongs_to :attachable, polymorphic: true
  has_one_attached :venue_file, dependent: :destroy

  default_scope { order(created_at: :desc) }
end
