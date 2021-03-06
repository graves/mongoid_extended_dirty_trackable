require 'spec_helper'
require 'models/relationships'

describe Mongoid::ExtendedDirtyTrackable do
  it "has a version number" do
    expect(Mongoid::ExtendedDirtyTrackable::VERSION).not_to be nil
  end

  it "it is wired in correctly" do
    expect(Account.new.singleton_class < Mongoid::ExtendedDirtyTrackable)
      .to eq(true)
  end
end

describe Account do
  it "detects changes to itself" do
    account = Account.create(:name => "Umbrella Corp")
    account.name = "Prestige Worldwide"

    expect(account.changed?).to eq(true)
  end

  it "detects changes to embedded 1-1 relations" do
    account = Account.create
    account.create_address(zipcode: "90210")
    account.address.zipcode = "1000 AS"

    expect(account.changed?).to eq(true)
    expect(account.changes["zipcode"]).to eq(["90210", "1000 AS"])
  end

  it "detects changes to embedded 1-N relations" do
    account = Account.create
    account.invoices.create(total: 420.00)
    account.invoices.first.total = 69.69

    expect(account.changed?).to eq(true)
    expect(account.changes["total"]).to eq([420.00, 69.69])
  end

  it "detects changes to referenced 1-N relations" do
    account = Account.create
    office = account.offices.create(number: 666)
    office.number = 8675309

    expect(account.changed?).to eq(true)
    expect(account.changes["number"]).to eq([666, 8675309])
  end
end



