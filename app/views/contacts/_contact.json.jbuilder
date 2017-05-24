json.extract! contact, :id, :name, :email, :tel, :message, :role, :subject, :read, :created_at, :updated_at
json.url contact_url(contact, format: :json)