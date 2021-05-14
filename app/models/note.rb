class Note < ApplicationRecord
  belongs_to :user
  belongs_to :notable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }
end
