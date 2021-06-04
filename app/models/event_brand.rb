class EventBrand < ApplicationRecord
  belongs_to :event
  belongs_to :brand
  validates_uniqueness_of :brand_id, scope: :event_id
end
