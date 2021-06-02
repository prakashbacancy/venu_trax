class Klass < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :groups, dependent: :destroy

  scope :business, -> { find_by(name: 'Business') }
  scope :user, -> { find_by(name: 'User') }
  scope :venue, -> { find_by(name: 'Venue') }

  def constant
    @constant ||= self.name.constantize
  end

  def field_picklist_valuable_fields
    fields.field_picklist_valuable
  end
end
