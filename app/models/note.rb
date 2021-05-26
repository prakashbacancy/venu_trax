class Note < ApplicationRecord
  belongs_to :user
  belongs_to :notable, polymorphic: true
  has_many :comments, as: :commentable

  default_scope { order(created_at: :desc) }

  scope :recent, -> { order(created_at: :desc) }
end
