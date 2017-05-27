class Category < ActiveResource::Base
  self.site = ENV['api_url']
  add_response_method :http_response

  schema do
  	string :title
  	string :ancestry
  end
end