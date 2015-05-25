# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/extended_dirty_trackable/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_extended_dirty_trackable"
  spec.version       = Mongoid::ExtendedDirtyTrackable::VERSION
  spec.authors       = ["Thomas Graves"]
  spec.email         = ["thomas@ooo.pm"]

  spec.summary       = "Mongoid extension for tracking changes to embedded and related documents"
  spec.description   = <<-EOS
    An ActiveSupport::Concern that extends Mongoid to give you a mixin for tracking changes to embedded and related documents
  EOS
  spec.homepage      = "https://github.com/graves/mongoid_extended_dirty_trackable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '~> 3.0'
  spec.add_runtime_dependency 'mongoid', '>= 3.1.0', '< 4.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
