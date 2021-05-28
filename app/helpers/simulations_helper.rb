module SimulationsHelper
	def hide_table(filter_name, filter)
		return if filter_name == nil
		if (filter_name == filter || filter_name == "All")
			"show"
		else
			"hide"
		end
	end

	def action_name(params, object)
		@simulation.new_record? ? [simulations_path, :post] : [simulation_path(object), :put]
	end

	def display_two_digit_with_delimiter(val)
    val = val.to_f
    val = (val < 0) ? 0 : val
    number_to_delimited('%.2f' % val.to_f)
  end
end
