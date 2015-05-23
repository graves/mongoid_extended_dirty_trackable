require 'rubygems'
require 'bundler/setup'
require 'mongoid'
require 'mongoid_extended_dirty_trackable'

require 'rspec'

Mongoid.configure do |config|
  name = "mongoid_test_db"
  host = "localhost"
  config.connect_to(name)
end

RSpec.configure do |config|
  config.after(:suite) do
    Mongoid.purge!
  end
end
