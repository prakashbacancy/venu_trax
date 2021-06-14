class Business < ApplicationRecord
  has_one_attached :logo, dependent: :destroy

  has_many :notes, as: :notable
  has_many :venues, dependent: :destroy

  PERMITTED_PARAM = %w[id name industry business_type phone_no zip_code address city state
                       no_of_employee annual_revenue description domain logo].freeze
  INDUSTRY = ['State and Local Government',
              'Finance and insurance',
              'Health/social care',
              'Durable manufacturing',
              'Retail trade',
              'Wholesale trade',
              'Non-durable manufacturing',
              'Federal Government',
              'Information',
              'Arts, entertainment',
              'Waste services',
              'Other services',
              'Utilities',
              'Mining',
              'Corporate management',
              'Education services',
              'Agriculture'].sort

  TYPE = %w[Prospect
            Partner
            Reseller
            Vendor
            Other].freeze
end
