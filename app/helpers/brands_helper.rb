module BrandsHelper
	def no_data_available
    '<div class="text-center text-gray fs-15">No Data Available</div>'.html_safe
  end

  def no_data_available_for_table
    '<tr><td colspan="5" class="text-center text-gray">No Data Available</td></tr>'.html_safe
  end

  def brand_group(group_id)
    Group.find_by(id: group_id)
  end
end
