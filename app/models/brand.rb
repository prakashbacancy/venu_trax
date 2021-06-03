class Brand < ApplicationRecord
  has_many :event_brands
  has_many :events, through: :event_brands
end
