# -*- encoding: utf-8 -*-

Dir["#{File.dirname(__FILE__)}/dsl/*.rb"].each do |path|
  require "git-shizzle/dsl/#{File.basename(path, '.rb')}"
end

module GitShizzle::Dsl
end
