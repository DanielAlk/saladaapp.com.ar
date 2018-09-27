class PagesController < ApplicationController
	layout :set_layout
	
	def home
	end

	def packs
		roles = { visitante: :client, comerciante: :seller }
		@role = roles[params[:role].to_sym]
	end

	def blog
	end

	def article
	end

	def privacy_policy
	end

	private
		def set_layout
			if action_name.to_sym == :privacy_policy
				'privacy_policy'
			else
				'pages'
			end
		end
end
