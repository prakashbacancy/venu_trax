module EventsHelper
  def brand_option(brands)
    brands.collect { |brand| [brand.name, brand.id] }
  end

  def brand_option_js(brands)
    brands.collect { |brand| [brand.id.to_s, brand.name.to_s] }.to_h.to_s
  end
end
