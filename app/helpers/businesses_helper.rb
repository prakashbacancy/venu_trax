module BusinessesHelper
  def business_group(group_id)
    Group.find_by(id: group_id)
  end
end
