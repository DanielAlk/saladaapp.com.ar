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

	def reset_password
		if params[:client_id]
			cookies[:reset_password] = {
				value: JSON.generate(params.permit(:client_id, :token, :uid)),
				expires: Time.now + 1.minute
			}
		elsif cookies[:reset_password].blank?
			redirect_to root_url
		end
	end

	def privacy_policy
	end

	def terms_and_conditions
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
