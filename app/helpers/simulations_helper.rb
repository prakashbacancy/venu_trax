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
end
