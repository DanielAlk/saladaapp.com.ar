class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :retrieve_panel_data
  #before_action :authenticate_panel, if: -> { request.subdomain.starts_with?('panel') }

  private
  	def retrieve_panel_data
  		@panel_data = { unread_contacts_count: Contact.unread.count }
  	end
  	def authenticate_panel
  		if (controller_name != 'panel' || action_name != 'login') && cookies['authHeaders'].blank?
  			redirect_to panel_login_url, alert: 'Ingresá tu usuario y contraseña'
  		elsif controller_name == 'panel' && action_name == 'login' && cookies['authHeaders'].present?
  			redirect_to panel_url
  		end
  	end
end
