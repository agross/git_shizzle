lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbconfig'
require 'git_shizzle/version'

Gem::Specification.new do |s|
  s.name        = 'git_shizzle'
  s.version     = GitShizzle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Bjoern Rochel', 'Alexander Groß']
  s.email       = ['bjoern@bjro.de', 'agross@therightstuff.de']
  s.homepage    = 'http://grossweber.com'
  s.license     = 'BSD'
  s.description = %q{git_shizzle lets you quickly operate on the file lists printed by `git status`. Imagine a number before each line of the status output and use that index to specify the file you want to operate on. For example, to stage the first file in the list of "Changes not staged for commit", run `quick-git stage 1`.}
  s.summary     = %q{Quickly operate on the git working copy and the index}

  s.add_dependency 'thor', '~> 0.16'

  s.add_development_dependency 'rspec', '>= 3.0.0.beta2'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rspec'

  case RbConfig::CONFIG['target_os']
  when /windows|bccwin|cygwin|djgpp|mingw|mswin|wince/i
    s.add_development_dependency 'ruby_gntp'
    s.add_development_dependency 'wdm'
  when /linux/i
    s.add_development_dependency 'rb-inotify'
  when /mac|darwin/i
    s.add_development_dependency 'rb-fsevent'
    s.add_development_dependency 'growl'
  end

  git = ENV['TEAMCITY_GIT_PATH'] || 'git'
  s.files         = `"#{git}" ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
end
