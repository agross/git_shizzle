# -*- encoding: utf-8 -*-

module GitShizzle::IndexSpecifications
  class IndexSpecificationError < GitShizzle::Error
    def initialize(indexes)
      super "Could not determine files for indexes: #{indexes.join(', ')}"
    end
  end

  class IndexParserError < GitShizzle::Error
    def initialize(index)
      super "Could not parse index '#{index}'. Please use numeric indexes or Ruby-style ranges."
    end
  end

  class NoFilesError < GitShizzle::Error
    def initialize(action)
      super "No files for action #{action}."
    end
  end
end
