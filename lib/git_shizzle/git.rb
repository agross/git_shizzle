# -*- encoding: utf-8 -*-

Dir["#{File.dirname(__FILE__)}/git/*.rb"].each do |path|
  require "git_shizzle/git/#{File.basename(path, '.rb')}"
end

module GitShizzle::Git
end
