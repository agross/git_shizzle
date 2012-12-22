# -*- encoding: utf-8 -*-

# This is a base class, so we have to require it first. Better ideas, @bjro?
require "git-shizzle/index_specifications/index_specification"

Dir["#{File.dirname(__FILE__)}/index_specifications/*.rb"].each do |path|
  require "git-shizzle/index_specifications/#{File.basename(path, '.rb')}"
end

module GitShizzle::IndexSpecifications
end
