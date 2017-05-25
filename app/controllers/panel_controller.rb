class PanelController < ApplicationController
	layout :select_layout

  def home
  	@users = User.all
  	@categories = Category.all
  	@shops = Shop.all
  	@contacts = Contact.all
  end

  def login
  end

  private
  	def select_layout
  		'clean' if action_name.to_sym == :login
  	end
end
