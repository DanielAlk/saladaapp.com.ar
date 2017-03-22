class Payment < ActiveResource::Base
  self.site = ENV['api_url']
end