# -*- encoding: utf-8 -*-

require 'git_shizzle/index_specifications/base'

Dir["#{File.dirname(__FILE__)}/index_specifications/*.rb"].each do |path|
  require "git_shizzle/index_specifications/#{File.basename(path, '.rb')}"
end

module GitShizzle::IndexSpecifications
end
