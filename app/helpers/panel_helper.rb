module PanelHelper
	def sidebar_link_class(controller, action = false)
		'active' if controller_name.to_sym == controller && (action.blank? || action_name.to_sym == action)
	end
end
