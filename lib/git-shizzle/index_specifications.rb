# -*- encoding: utf-8 -*-

module GitShizzle::IndexSpecifications
  require "git-shizzle/index_specifications/index_specification_error"
  require "git-shizzle/index_specifications/index_specification"

  require "git-shizzle/index_specifications/everything"
  require "git-shizzle/index_specifications/file"
  require "git-shizzle/index_specifications/range"
  require "git-shizzle/index_specifications/exclusive_range"
  require "git-shizzle/index_specifications/combined"
end
