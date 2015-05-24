require_relative '../spec_helper.rb'

class Account
  include Mongoid::Document
  include Mongoid::ExtendedDirtyTrackable

  field :name

  embeds_one :address
  embeds_many :invoices
  has_many :offices
end

class Address
  include Mongoid::Document

  field :zipcode

  embedded_in :account
end

class Invoice
  include Mongoid::Document

  field :total

  embedded_in :account
end

class Office
  include Mongoid::Document

  field :number

  belongs_to :account
end
