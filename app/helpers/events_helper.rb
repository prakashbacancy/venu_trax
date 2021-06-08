module EventsHelper
  # For brand select box
  def brand_option(brands)
    brands.collect { |brand| [brand.name, brand.id] }
  end

  # For brands js variable
  def brand_option_js(brands)
    brands.collect { |brand| [brand.id.to_s, brand.name.to_s] }.to_h.to_s
  end

  # To make whole time into String
  def time_string(days, hour, min)
    time_array = []
    # If difference positive insert into Array
    time_array << "#{days} Days" if days.positive?
    time_array << "#{hour} Hours" if hour.positive?
    time_array << "#{min} Mins" if min.positive?
    time_array.join(', ')
  end

  # To find out Time difference for event details page
  def time_diff(start_date_time, end_date_time)
    seconds = ((end_date_time - start_date_time) * 24 * 60 * 60).to_i
    minutes = seconds / 60
    min = minutes % 60
    hours = minutes / 60
    hour = hours % 24
    days = hours / 24
    time_string(days, hour, min)
  end

  # NOTE: Just for static brands. Until Brands module develop
  def brand_logo(brand)
    brand_name = {
      'Apple': 'ic_apple.png',
      'McDonalds': 'ic_mcdonald.png',
      'Microsoft': 'ic_microsoft.png',
      'Facebook': 'ic_facebook.png'
    }
    brand_name[brand.name.to_sym]
  end

  def no_data_available
    '<tr><td colspan="6" class="text-center text-gray">No Data Available</td></tr>'.html_safe
  end
end
