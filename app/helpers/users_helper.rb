module UsersHelper
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
