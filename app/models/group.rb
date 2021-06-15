class Group < ApplicationRecord
  has_ancestry orphan_strategy: :rootify

  default_scope { order(:position) }

  belongs_to :klass

  has_many :fields, dependent: :destroy
  scope :venue_basic, -> { find_by(name: 'Venue Information', klass_id: Klass.venue.id) }
  scope :business_basic, -> { find_by(name: 'Business Information', klass_id: Klass.business.id) }
  scope :event_basic, -> { find_by(name: 'Event Information', klass_id: Klass.event.id) }
  scope :brand_basic, -> { find_by(name: 'Brand Information', klass_id: Klass.brand.id) }

  # has_many :role_resources, as: :resource, dependent: :destroy
  # before_create :create_role_resources

  PERMITTED_PARAM = %w[id name label klass_id parent_id].freeze

  def parent_label
    self.parent&.label
  end

  def self.root_groups_except(group)
    root_groups.where.not(id: group.id)
  end

  def self.root_groups
    roots
  end

  def self.defaults
    all.where(default: true)
  end

  # Used for rendering
  def field_picklist_valuable_fields
    fields.field_picklist_valuable
  end

  def create_role_resources
    Role.all.each do |role|
      Action.all.each do |action|
        self.role_resources.build(role: role, action: action)
      end
    end
  end
end
