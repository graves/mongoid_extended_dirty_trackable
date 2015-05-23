require_relative '../../spec_helper'
require_relative '../../../lib/mongoid_extended_dirty_trackable.rb'
require 'pry'

class Account
  include Mongoid::Document
  include Mongoid::ExtendedDirtyTrackable

  field :name

  embeds_one :address
end

class Address
  include Mongoid::Document

  field :zipcode

  embedded_in :account
end

describe Mongoid::ExtendedDirtyTrackable do
  it 'has a version number' do
    expect(Mongoid::ExtendedDirtyTrackable::VERSION).not_to be nil
  end

  it 'it is wired in correctly as a mixin' do
    expect(Account.new.singleton_class < Mongoid::ExtendedDirtyTrackable)
      .to eq(true)
  end
end

describe Account do
  it "detects changes to itself" do
    account = Account.new(:name => "Umbrella Corp")
    account.save!
    account.name = "Prestige Worldwide"

    expect(account.changed?).to eq(true)
  end

  it "detects changes to embedded_one documents" do
    account = Account.new
    account.create_address(zipcode: "90210")
    account.address.zipcode = "1000 AS"

    expect(account.changed?).to eq(true)
    expect(account.changes["zipcode"]).to eq(["90210", "1000 AS"])
  end
end



