# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class IndexSpecificationError < StandardError
      include GitShizzle::Error
    end
  end
end
