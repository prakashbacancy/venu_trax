class Klass < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :groups, dependent: :destroy

  scope :business, -> { find_by(name: 'Business') }
  scope :user, -> { find_by(name: 'User') }
  scope :venue, -> { find_by(name: 'Venue') }
  scope :event, -> { find_by(name: 'Event') }
  scope :brand, -> { find_by(name: 'Brand') }

  validates :name, uniqueness: { case_sensitive: false, message: 'Entered klass name is already in use' }, allow_nil: false

  def constant
    @constant ||= self.name.constantize
  end

  def field_picklist_valuable_fields
    fields.field_picklist_valuable
  end
end
