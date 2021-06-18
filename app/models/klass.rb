class Klass < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :groups, dependent: :destroy

  scope :business, -> { find_by(name: 'Business') }
  scope :user, -> { find_by(name: 'User') }
  scope :venue, -> { find_by(name: 'Venue') }
  scope :event, -> { find_by(name: 'Event') }
  scope :brand, -> { find_by(name: 'Brand') }

  validates :name, uniqueness: { case_sensitive: false, message: 'Entered klass name is already in use' },
                   allow_nil: false

  # Consider `ts_name` as `tableize_singularize_name`
  DYNAMIC_KLASSES = [{ name: 'Business', ts_name: 'business' },
                     { name: 'User', ts_name: 'user' },
                     { name: 'Venue', ts_name: 'venue' },
                     { name: 'Event', ts_name: 'event' },
                     { name: 'Brand', ts_name: 'brand' }].freeze

  def constant
    @constant ||= name.constantize
  end

  def field_picklist_valuable_fields
    fields.field_picklist_valuable
  end
end
