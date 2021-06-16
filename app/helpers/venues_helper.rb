module VenuesHelper
  def check_google_token
    current_user.google_access_token.blank?
  end

  def meeting_attendees(meeting)
    User.where(id: meeting.attendees.pluck(:resourceable_id)).pluck(:full_name, :email).map{ |s| s.join(' - ') }.join(' &#013;').html_safe
  end

  def venue_group(group_id)
    Group.find_by(id: group_id)
  end

  def meeting_attendees_for_modal(meeting)
    User.where(id: meeting.attendees.pluck(:resourceable_id))
  end
end
