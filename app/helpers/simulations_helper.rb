module SimulationsHelper
	def hide_table(filter_name, filter)
		puts "================#{filter_name}"
		return if filter_name == nil
		if (filter_name == filter || filter_name == "All")
			"show"
		else
			"hide"
		end
	end
end
