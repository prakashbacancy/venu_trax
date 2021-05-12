class Business < ApplicationRecord

  has_many :venues

  PERMITTED_PARAM = %w[id name industry business_type phone_no zip_code address city state
                       no_of_employee annual_revenue description domain].freeze
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
            Vandor
            Other].freeze
end
