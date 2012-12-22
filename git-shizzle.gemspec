# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'rbconfig'
require 'git-shizzle/version'

Gem::Specification.new do |s|
  s.name        = 'git-shizzle'
  s.version     = GitShizzle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Bjoern Rochel', 'Alexander Groß']
  s.email       = ['bjoern@bjro.de', 'agross@therightstuff.de']
  s.homepage    = ""
  s.summary     = %q{More or less useful extensions for git}

  s.add_dependency 'thor',          '~>0.16.0'
  s.add_dependency 'activesupport', '~>3.2.9'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'

  if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i
    s.add_development_dependency 'win32console'
    s.add_development_dependency 'ruby_gntp'
  else
    s.add_development_dependency 'rb-fsevent'
    s.add_development_dependency 'growl'
  end

  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
