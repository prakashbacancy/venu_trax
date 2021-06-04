class Event < ApplicationRecord
  belongs_to :venue

  has_many :event_brands, dependent: :destroy
  has_many :brands, through: :event_brands

  accepts_nested_attributes_for :event_brands, reject_if: :all_blank, allow_destroy: true

  PERMITTED_PARAM = [:id, :title, :start_date, :start_time, :end_date, :end_time, :description,
                     { event_brands_attributes: %i[id brand_id event_id _destroy] }].freeze

  def start_date_time
    DateTime.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min, start_time.sec,
                 start_time.zone)
  end

  def end_date_time
    DateTime.new(end_date.year, end_date.month, end_date.day, end_time.hour, end_time.min, end_time.sec, end_time.zone)
  end
end
