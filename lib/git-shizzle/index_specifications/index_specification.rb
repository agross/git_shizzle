# -*- encoding: utf-8 -*-

module GitShizzle::IndexSpecifications
  class IndexSpecification
    def include?(index)
      false
    end

    def register_match(index)
      matches << index
    end

    def matches
      @matches ||= []
    end

    def unmatched
    end

    private
    def assert_numeric(index, *spec)
      spec << index if spec.empty?

      all_numeric = spec.all? { |s|
        s.is_a? Numeric or /\d+/.match(s)
      }

      raise IndexParserError.new(index) unless all_numeric
    end
  end
end
