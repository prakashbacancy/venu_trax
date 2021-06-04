class Brand < ApplicationRecord
  has_many :event_brands, dependent: :destroy
  has_many :events, through: :event_brands
end
