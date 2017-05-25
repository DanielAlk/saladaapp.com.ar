class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :retrieve_panel_data

  private
  	def retrieve_panel_data
  		@panel_data = { unread_contacts_count: Contact.unread.count }
  	end
end
