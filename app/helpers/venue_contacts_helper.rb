module VenueContactsHelper
  def no_data_available
    '<div class="text-center text-gray fs-15">No Data Available</div>'.html_safe
  end

  def no_data_available_for_table
    '<tr><td colspan="5" class="text-center text-gray">No Data Available</td></tr>'.html_safe
  end

  def user_status_option(user_statuses)
    user_statuses.collect { |user_status| [user_status.capitalize, user_status] }
  end

  def status_class(status)
    status_hash = {
      'active': 'bg-green',
      'inactive': 'bg-red',
      'invited': 'not-allowed bg-yellow'
    }
    status_hash[status]
  end
end
