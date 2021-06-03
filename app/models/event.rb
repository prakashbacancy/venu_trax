class Event < ApplicationRecord
  belongs_to :venue

  has_many :event_brands
  has_many :brands, through: :event_brands

  PERMITTED_PARAM = [:id, :title, :start_date, :start_time, :end_date, :end_time, :description,
                     { brand_ids: [] }].freeze

  def start_date_time
    DateTime.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min, start_time.sec,
                 start_time.zone)
  end

  def end_date_time
    DateTime.new(end_date.year, end_date.month, end_date.day, end_time.hour, end_time.min, end_time.sec, end_time.zone)
  end
end
