module MeetingsHelper
  def all_attendees
    attendees = {}
    users = current_user.all_without_contact_user.map { |u| [u.full_name, u.to_polymorphic] }
    venue_contacts = @meeting.meetingable.venue_contacts.map { |u| [u.full_name, u.user.to_polymorphic] }
    attendees[:Users] = users if users.present?
    attendees[:VenueContacts] = venue_contacts if venue_contacts.present?
    attendees
  end

  def value_of_attendees_for_select(meeting)
    meeting.attendees.map { |attendee| attendee.resourceable.to_polymorphic }
  end

  def find_time_difference_in_minutes(start_time, end_time)
    ((start_time.to_datetime - end_time.to_datetime) * 24 * 60).to_i.abs
  end
end
