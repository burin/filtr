# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "filtr/version"

Gem::Specification.new do |s|
  s.name        = "filtr"
  s.version     = Filtr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Burin Asavesna"]
  s.email       = ["burinasavesna@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/filtr"
  s.summary     = %q{Wrapper for ImageMagick to provide vintage filter effects on photos.}
  s.description = %q{Wrapper for ImageMagick to provide vintage filter effects on photos.}

  s.rubyforge_project = "filtr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
