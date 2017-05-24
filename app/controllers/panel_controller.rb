class PanelController < ApplicationController
  def home
  	@users = User.all
  	@categories = Category.all
  	@shops = Shop.all
  	@contacts = Contact.all
  end
end
