module MeetingsHelper
  def all_attendees
    { Users: current_user.all_without_contact_user.map { |u| [u.full_name, u.to_polymorphic] },
      VenueContacts: @meeting.meetingable.venue_contacts.map { |u| [u.full_name, u.user.to_polymorphic] } }
  end

  def value_of_attendees_for_select(meeting)
    meeting.attendees.map { |attendee| attendee.resourceable.to_polymorphic }
  end

  def find_time_difference_in_minutes(start_time, end_time)
    ((start_time.to_datetime - end_time.to_datetime) * 24 * 60).to_i.abs
  end
end
