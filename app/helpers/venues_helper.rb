module VenuesHelper
  def check_google_token
    current_user.google_token_expired? || current_user.google_access_token.blank?
  end

  def meeting_attendees(meeting)
    User.where(id: meeting.attendees.pluck(:resourceable_id)).pluck(:full_name, :email).map{ |s| s.join(' - ') }.join(' &#013;').html_safe
  end
end
