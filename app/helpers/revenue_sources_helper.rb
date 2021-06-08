module RevenueSourcesHelper
  def brand_option(brands)
    brands.collect { |brand| [brand.name, brand.id] }
  end
end
