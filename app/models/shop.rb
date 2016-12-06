class Shop < ActiveResource::Base
  self.site = ENV['api_url']
end