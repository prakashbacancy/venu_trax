class FieldPicklistValue < ApplicationRecord
  # default_scope { order(:position) }
  # This is just for temporary purpose
  default_scope { order(created_at: :asc) }

  belongs_to :field

  before_update :update_records_to_new_value
  before_destroy :update_records_to_nil

  private

  def update_records_to_new_value
    field.klass.constant.where(field.name => value_was).update_all(field.name => value) if value_changed?
  end

  def update_records_to_nil
    field.klass.constant.where(field.name => value).update_all(field.name => nil)
  end
end
