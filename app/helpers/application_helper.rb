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

  def time_zone_options
    ActiveSupport::TimeZone.all.collect{|tz| [tz.to_s, tz.name]}
  end

  def dynamic_display_two_digit(val)
    return nil if val.blank?

    val = val.to_f
    val = (val < 0) ? 0 : val
    '%.2f' % val.to_f
  end

  def error_message(object, field, options = {})
    content_tag(:div, object.errors.full_message(field, object.errors[field].join('')), class: options) if (object.errors.present? && object.errors[field].present?)
  end

  def format_float(val)
    sprintf '%.2f', val.to_f
  end

  def time_date(date)
    if date.year > Time.now.year
      date.strftime('%d/%m/%y')
    else
      date.to_date == Time.now.to_date ? date.strftime('%l:%M %p') : date.strftime('%b %d')
    end
  end

  def pretty_days_from_float(days)
    if days.present?
      "#{days.to_i} Days"
    else
      '-'
    end
  end

  def pretty_days_from_dates(start_date, end_date)
    if start_date.present? && end_date.present?
      "#{(end_date.to_date - start_date.to_date).to_i} Days"
    else
      '-'
    end
  end

  def pretty_hours_from_number(number)
    return unless number.present?
    minutes = (number / 60) % 60
    hours = number / (60 * 60)
    format('%02d:%02d', hours, minutes)
  end

  def parse_multi_select(serialized)
    serialized ||= "[]"
    JSON.parse(serialized).join(', ')
  end

  def pretty_amount(amount)
    '$%.2f' % amount.to_f
  end

  def pretty_date_time(date_time)
    date_time.try(:strftime, '%m/%d/%Y, %I:%M %p')
  end

  def pretty_date(date)
    date.try(:strftime, '%m/%d/%Y')
  end

  def pretty_time(time)
    time.try(:strftime, '%l:%M %p')
  end

  def convert_into_time_zone(date)
    time_zone = current_user.active_support_timezone
    date.in_time_zone(time_zone)
  end

  # def pretty_reference(field, object)
  #   if (id = object.send(field.name))
  #     field.reference_klass.constantize.find(id).send(field.reference_key)
  #   end
  # end

  def pretty_checkbox(value)
    return 'Yes' if value == '1' || value == 't' || value == 'true' || value == true
    return 'No'
  end

  def pretty_file_associations(file_associations)
    return unless file_associations.present?
    str = '<div class="col-md-12">'
    file_associations.each do |file_association|
      str += link_to file_association.file.attachment.url, target: :_blank, class: 'common-link' do
        "<i class='fa fa-file' aria-hidden='true'></i> #{file_association.file.attachment.file.filename.truncate(20)}".html_safe
      end
    end
    str += '</div>'
    str.html_safe
  end

  def render_field(field, object)
    return pretty_date(object.send(field.name)) if field.column_type == 'Date'
    return pretty_time(object.send(field.name)) if field.column_type == 'Time'
    return pretty_date_time(object.send(field.name)) if field.column_type == 'DateTime'
    return '<p></p>'.html_safe if field.column_type == 'Label'
    return parse_multi_select(object.send(field.name)) if field.column_type == 'Multi-Select Check Box'
    return "<a href='http://#{object.send(field.name)}' target='_blank'>#{object.send(field.name)}</a>".html_safe if field.column_type == 'URL'
    return "<iframe srcdoc='#{object.send(field.name)}'></iframe>".html_safe if field.column_type == 'Text Area HTML'
    return pretty_checkbox(object.send(field.name)) if field.column_type == 'Checkbox'
    return pretty_file_associations(object.file_manager_file_associations.where(field: field)) if field.column_type == 'File'
    return object.user.full_name if field.name == 'user_id'
    return "$ #{display_two_digit(object.send(field.name))}" if field.column_type == 'Currency'

    # return pretty_reference(field, object) if field.reference?
    return object.send(field.name)
  end

  def pretty_value(field, object)
    value = render_field(field, object)
    return value.present? ? value : 'N/A'
  end

  def venue_contact?(user)
    user.try(:contact) == 'venue_contact'
  end
end
