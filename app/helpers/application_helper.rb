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
end
