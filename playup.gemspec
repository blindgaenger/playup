# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "playup/version"

Gem::Specification.new do |s|
  s.name        = "playup"
  s.version     = Playup::VERSION
  s.authors     = ["Bernd Jünger"]
  s.email       = ["blindgaenger@gmail.com"]
  s.homepage    = "http://blindgaenger.net"
  s.summary     = %q{Setup for playgrounds}
  s.description = %q{Some templates to setup environments for playing around}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "thor"
end
