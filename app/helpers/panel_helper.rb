module PanelHelper
	def sidebar_link_class(controller, action)
		'active' if controller_name.to_sym == controller && action_name.to_sym == action
	end
end
