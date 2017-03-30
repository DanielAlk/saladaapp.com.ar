class Category < ActiveResource::Base
  self.site = ENV['api_url']

  schema do
  	string :title
  	string :ancestry
  end
end