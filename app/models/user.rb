class User < ActiveResource::Base
  self.site = ENV['api_url']
  add_response_method :http_response

  has_many :shops

  def self.roles
  	{ Cliente: :client, Vendedor: :seller }
  end
  def self.genders
  	{ Masculino: :male, Femenino: :female }
  end
  def self.id_types
  	[ :DNI, :CI, :Otro ]
  end
end