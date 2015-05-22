require_relative '../../spec_helper'

describe Mongoid::ExtendedDirtyTrackable do
  it 'has a version number' do
    expect(Mongoid::ExtendedDirtyTrackable::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
