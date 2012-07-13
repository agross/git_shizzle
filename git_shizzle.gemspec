# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git_shizzle/version"

Gem::Specification.new do |s|
  s.name        = "Git Shizzle"
  s.version     = GitShizzle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bjoern Rochel", "Alexander Groß"]
  s.email       = ["bjoern@bjro.de", "agross@therightstuff.de"]
  s.homepage    = ""
  s.summary     = %q{More or less useful extensions for git}

  s.add_dependency "thor"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "growl"
  s.add_development_dependency "ruby-debug19"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end