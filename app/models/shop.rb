class Shop < ActiveResource::Base
  self.site = ENV['api_url']
  add_response_method :http_response

  schema do
  	integer :user_id
  	integer :shed_id
  	integer :category_id
  	string :description
  	integer :location
  	string :location_detail
  	integer :location_floor
  	integer :location_row
  	string :gallery_name
  	integer :number_id
  	string :letter_id
  	boolean :fixed
  	string :opens
  	integer :condition
  	integer :rating
  	string :image
  	integer :status
  end
end