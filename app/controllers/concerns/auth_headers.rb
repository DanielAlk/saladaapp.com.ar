module AuthHeaders
	extend ActiveSupport::Concern

	included do
		before_action :auth_headers, only: [:create, :update, :destroy]
		after_action :auth_headers_save, only: [:create, :update, :destroy]
	end

	def auth_headers
    Shop.user = cookies['authHeaders']
  end

  def auth_headers_save
  	if (@shop.http_response['access-token'].present? rescue false)
	    auth = {}
	    auth['access-token'] = @shop.http_response['access-token']
	    auth['token-type'] = @shop.http_response['token-type']
	    auth['client'] = @shop.http_response['client']
	    auth['expiry'] = @shop.http_response['expiry']
	    auth['uid'] = @shop.http_response['uid']
	    cookies['authHeaders'] = { value: auth.to_json, expires: 14.days.from_now, path: '/' }
	  end
  end
end