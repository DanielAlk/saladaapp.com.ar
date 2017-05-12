class PagesController < ApplicationController
	layout 'pages'
	
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
end
