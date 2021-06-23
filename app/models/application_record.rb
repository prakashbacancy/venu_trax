class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.snakecase(custom_string)
    custom_string.downcase.gsub(/[^a-z0-9]+/, '_').first(60)
  end
end
