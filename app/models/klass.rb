class Klass < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :groups, dependent: :destroy

  scope :business, -> { find_by(name: 'Business') }
  scope :user, -> { find_by(name: 'User') }
  scope :venue, -> { find_by(name: 'Venue') }
  scope :venue_contact, -> { find_by(name: 'VenueContact') }
  scope :event, -> { find_by(name: 'Event') }
  scope :brand, -> { find_by(name: 'Brand') }
  scope :brand_contact, -> { find_by(name: 'BrandContact') }

  validates :name, uniqueness: { case_sensitive: false, message: 'Entered klass name is already in use' },
                   allow_nil: false

  # Consider `ts_name` as `tableize_singularize_name`
  DYNAMIC_KLASSES = [{ name: 'Business', ts_name: 'business' },
                     { name: 'User', ts_name: 'user' },
                     { name: 'Venue', ts_name: 'venue' },
                     { name: 'Venue Contact', ts_name: 'venue_contact' },
                     { name: 'Event', ts_name: 'event' },
                     { name: 'Brand', ts_name: 'brand' },
                     { name: 'Brand Contact', ts_name: 'brand_contact' }].freeze

  def constant
    @constant ||= name.constantize
  end

  def field_picklist_valuable_fields
    fields.field_picklist_valuable
  end
end
