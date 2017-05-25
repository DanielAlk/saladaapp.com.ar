class Contact < ActiveResource::Base
  self.site = ENV['api_url']
  add_response_method :http_response

  def self.unread
    Contact.all(params: { f: { scopes: { read: 0 } }.to_json })
  end

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