module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then 'alert-success'
    when 'success' then 'alert-success'
    when 'error' then 'alert-error'
    when 'alert' then 'alert-error'
    end
  end

  def url_simplifier(url)
    (url.start_with?('http://') || url.start_with?('https://')) ? url : "http://#{url}"
  end

  def display_two_digit(val)
    val = val.to_f
    val = (val < 0) ? 0 : val
    '%.2f' % val.to_f
  end

  def time_date(date)
    if date.year > Time.now.year
      date.strftime('%d/%m/%y')
    else
      date.to_date == Time.now.to_date ? date.strftime('%l:%M %P') : date.strftime('%b %d')
    end
  end
end
