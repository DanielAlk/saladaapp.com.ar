class Contact < ActiveResource::Base
  self.site = ENV['api_url']
  add_response_method :http_response

  schema do
    string :name
    string :email
    string :tel
    text :message
    integer :role
    integer :subject
    boolean :read
  end
end